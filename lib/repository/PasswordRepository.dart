import 'package:encrypt/encrypt.dart';
import 'package:moor/moor.dart';
import 'package:pointycastle/api.dart';
import 'package:storage_infomation/database/db.dart' as db;

class Password {
  final int id;
  final String appName;
  final String icon;
  final String color;
  final String url;
  final String note;
  final String userName;
  final String password;
  final String plainText;

  Password({
    this.id, this.appName, this.icon, this.color, this.url,
    this.note, this.userName, this.password, this.plainText
  });

  Password.fromDataClass(db.Password dbPassword):
        id = dbPassword.id,
        appName = dbPassword.appName,
        icon = dbPassword.icon,
        color = dbPassword.color,
        url = dbPassword.url,
        note = dbPassword.note,
        userName = dbPassword.userName,
        password = dbPassword.password,
        plainText = null;

  Password copy({
    int id,
    String appName,
    String icon,
    String color,
    String url,
    String note,
    String userName,
    String password,
    String plainText,
  }) => Password(
    id: id ?? this.id,
    appName: appName ?? this.appName,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    url: url ?? this.url,
    note: note ?? this.note,
    userName: userName ?? this.userName,
    password: password ?? this.password,
    plainText: plainText ?? this.plainText,
  );
}

abstract class PasswordRepository {
  Future<List<Password>> retrievePasswords();

  Stream<List<Password>> watchPasswords();

  Future<Password> addEntry(Password password);

  Future<void> removePassword(Password password);

  Future<Password> updatePassword(Password password);

  Future<void> clearPasswords();
}

class RsaPasswordRepository extends PasswordRepository {
  static final db.Database _db = db.Database();

  AsymmetricKeyPair get keyPair => _keyPair;
  AsymmetricKeyPair _keyPair;
  Encrypter _encrypter;

  void setKeys(AsymmetricKeyPair keyPair) {
    _keyPair = keyPair;
    _encrypter = Encrypter(
        RSA(
            privateKey: _keyPair.privateKey,
            publicKey: _keyPair.publicKey,
            encoding: RSAEncoding.PKCS1
        )
    );
  }

  @override
  Future<List<Password>> retrievePasswords() async {
    return (await _db.allPasswords).map((e) {
      return Password.fromDataClass(e).copy(plainText: _encrypter.decrypt64(e.password));
    }).toList();
  }

  @override
  Stream<List<Password>> watchPasswords() =>
      _db.watchAllPasswords.map((dbPasswords) =>
          dbPasswords.map((dbP) =>
              Password.fromDataClass(dbP).copy(plainText: _encrypter.decrypt64(dbP.password))
          ).toList()
      );

  @override
  Future<Password> addEntry(Password password) async {
    Encrypted encrypted = _encrypter.encrypt(password.plainText);
    Password encryptedPassword = password.copy(password: encrypted.base64);
    final id = await _db.addPassword(db.PasswordsCompanion(
      appName: Value(encryptedPassword.appName),
      icon: Value(encryptedPassword.icon),
      color: Value(encryptedPassword.color),
      url: Value(encryptedPassword.url),
      note: Value(encryptedPassword.note),
      userName: Value(encryptedPassword.userName),
      password: Value(encryptedPassword.password)
    ));
    return encryptedPassword.copy(id: id);
  }

  @override
  Future<void> removePassword(Password password) => _db.removePassword(password.id);

  @override
  Future<Password> updatePassword(Password password) async {
    final encrypted = _encrypter.encrypt(password.plainText);
    final encryptedPassword = password.copy(password: encrypted.base64);
    await _db.updatePassword(db.PasswordsCompanion(
      id: Value(encryptedPassword.id),
      appName: Value(encryptedPassword.appName),
      icon: Value(encryptedPassword.icon),
      color: Value(encryptedPassword.color),
      url: Value(encryptedPassword.url),
      note: Value(encryptedPassword.note),
      userName: Value(encryptedPassword.userName),
      password: Value(encryptedPassword.password),
    ));
    return encryptedPassword;
  }

  @override
  Future<void> clearPasswords() async {
    await _db.clearPasswords();
    _keyPair = null;
  }
}