import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storage_infomation/pages/PasswordHomepage.dart';
import 'package:storage_infomation/repository/KeyRepository.dart';
import 'package:storage_infomation/repository/PasswordRepository.dart';

class SetMasterPassword extends StatefulWidget {
  @override
  _SetMasterPasswordState createState() => _SetMasterPasswordState();
}

class _SetMasterPasswordState extends State<SetMasterPassword> {
  TextEditingController masterPassController = TextEditingController();
  final _keyRepository = GetIt.I.get<KeyRepository>();
  final _passwordRepository = GetIt.I.get<PasswordRepository>();

  saveMasterPass(String password) async {
    // Todo validate password empty
    final keyPair = await _keyRepository.generateKeys();
    await _keyRepository.storePasswordEncryptedKeys(password, keyPair);
    if (_passwordRepository is RsaPasswordRepository) {
      (_passwordRepository as RsaPasswordRepository).setKeys(keyPair);
    }
    try {
      await _keyRepository.storeBiometricEncryptedKeys(keyPair);
    } catch(e) {
      print('Device not suport authentication biometric!!!');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Text("Master Password",
                    style: TextStyle(
                        fontFamily: "Title",
                        fontSize: 32,
                        color: primaryColor))),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Set Master Passwords for your all passwords. Keep your Master Password safe with you. This password will be used to unlock your encrypted passwords.",
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Subtitle"))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: true,
                maxLength: 32,
                decoration: InputDecoration(
                    labelText: "Master Pass",
                    labelStyle: TextStyle(fontFamily: "Subtitle"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: masterPassController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: size.width * 0.7,
                height: 60,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  color: primaryColor,
                  child: Text(
                    "CONFIRM",
                    style: TextStyle(color: Colors.white, fontFamily: "Title"),
                  ),
                  onPressed: () async {
                    if (masterPassController.text.isNotEmpty) {
                      saveMasterPass(masterPassController.text.trim());
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new PasswordHomepage(passwordRepo: _passwordRepository,)
                          )
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Error!",
                                style: TextStyle(fontFamily: "Title"),
                              ),
                              content: Text(
                                "Please enter valid Master Password.",
                                style: TextStyle(fontFamily: "Subtitle"),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("CLOSE"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
