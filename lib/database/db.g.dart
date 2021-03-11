// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Password extends DataClass implements Insertable<Password> {
  final int id;
  final String appName;
  final String icon;
  final String color;
  final String url;
  final String note;
  final String userName;
  final String password;
  Password(
      {@required this.id,
      @required this.appName,
      @required this.icon,
      @required this.color,
      @required this.url,
      @required this.note,
      @required this.userName,
      @required this.password});
  factory Password.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Password(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      appName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}app_name']),
      icon: stringType.mapFromDatabaseResponse(data['${effectivePrefix}icon']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
      userName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_name']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || appName != null) {
      map['app_name'] = Variable<String>(appName);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    return map;
  }

  PasswordsCompanion toCompanion(bool nullToAbsent) {
    return PasswordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      appName: appName == null && nullToAbsent
          ? const Value.absent()
          : Value(appName),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
    );
  }

  factory Password.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Password(
      id: serializer.fromJson<int>(json['id']),
      appName: serializer.fromJson<String>(json['appName']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<String>(json['color']),
      url: serializer.fromJson<String>(json['url']),
      note: serializer.fromJson<String>(json['note']),
      userName: serializer.fromJson<String>(json['userName']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'appName': serializer.toJson<String>(appName),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<String>(color),
      'url': serializer.toJson<String>(url),
      'note': serializer.toJson<String>(note),
      'userName': serializer.toJson<String>(userName),
      'password': serializer.toJson<String>(password),
    };
  }

  Password copyWith(
          {int id,
          String appName,
          String icon,
          String color,
          String url,
          String note,
          String userName,
          String password}) =>
      Password(
        id: id ?? this.id,
        appName: appName ?? this.appName,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        url: url ?? this.url,
        note: note ?? this.note,
        userName: userName ?? this.userName,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('Password(')
          ..write('id: $id, ')
          ..write('appName: $appName, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('userName: $userName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          appName.hashCode,
          $mrjc(
              icon.hashCode,
              $mrjc(
                  color.hashCode,
                  $mrjc(
                      url.hashCode,
                      $mrjc(note.hashCode,
                          $mrjc(userName.hashCode, password.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Password &&
          other.id == this.id &&
          other.appName == this.appName &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.url == this.url &&
          other.note == this.note &&
          other.userName == this.userName &&
          other.password == this.password);
}

class PasswordsCompanion extends UpdateCompanion<Password> {
  final Value<int> id;
  final Value<String> appName;
  final Value<String> icon;
  final Value<String> color;
  final Value<String> url;
  final Value<String> note;
  final Value<String> userName;
  final Value<String> password;
  const PasswordsCompanion({
    this.id = const Value.absent(),
    this.appName = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.url = const Value.absent(),
    this.note = const Value.absent(),
    this.userName = const Value.absent(),
    this.password = const Value.absent(),
  });
  PasswordsCompanion.insert({
    this.id = const Value.absent(),
    @required String appName,
    @required String icon,
    @required String color,
    @required String url,
    @required String note,
    @required String userName,
    @required String password,
  })  : appName = Value(appName),
        icon = Value(icon),
        color = Value(color),
        url = Value(url),
        note = Value(note),
        userName = Value(userName),
        password = Value(password);
  static Insertable<Password> custom({
    Expression<int> id,
    Expression<String> appName,
    Expression<String> icon,
    Expression<String> color,
    Expression<String> url,
    Expression<String> note,
    Expression<String> userName,
    Expression<String> password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appName != null) 'app_name': appName,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (url != null) 'url': url,
      if (note != null) 'note': note,
      if (userName != null) 'user_name': userName,
      if (password != null) 'password': password,
    });
  }

  PasswordsCompanion copyWith(
      {Value<int> id,
      Value<String> appName,
      Value<String> icon,
      Value<String> color,
      Value<String> url,
      Value<String> note,
      Value<String> userName,
      Value<String> password}) {
    return PasswordsCompanion(
      id: id ?? this.id,
      appName: appName ?? this.appName,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      url: url ?? this.url,
      note: note ?? this.note,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PasswordsCompanion(')
          ..write('id: $id, ')
          ..write('appName: $appName, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('userName: $userName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $PasswordsTable extends Passwords
    with TableInfo<$PasswordsTable, Password> {
  final GeneratedDatabase _db;
  final String _alias;
  $PasswordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _appNameMeta = const VerificationMeta('appName');
  GeneratedTextColumn _appName;
  @override
  GeneratedTextColumn get appName => _appName ??= _constructAppName();
  GeneratedTextColumn _constructAppName() {
    return GeneratedTextColumn(
      'app_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _iconMeta = const VerificationMeta('icon');
  GeneratedTextColumn _icon;
  @override
  GeneratedTextColumn get icon => _icon ??= _constructIcon();
  GeneratedTextColumn _constructIcon() {
    return GeneratedTextColumn(
      'icon',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn(
      'color',
      $tableName,
      false,
    );
  }

  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  @override
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn(
      'note',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  GeneratedTextColumn _userName;
  @override
  GeneratedTextColumn get userName => _userName ??= _constructUserName();
  GeneratedTextColumn _constructUserName() {
    return GeneratedTextColumn(
      'user_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, appName, icon, color, url, note, userName, password];
  @override
  $PasswordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'passwords';
  @override
  final String actualTableName = 'passwords';
  @override
  VerificationContext validateIntegrity(Insertable<Password> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('app_name')) {
      context.handle(_appNameMeta,
          appName.isAcceptableOrUnknown(data['app_name'], _appNameMeta));
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon'], _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url'], _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note'], _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name'], _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Password map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Password.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PasswordsTable createAlias(String alias) {
    return $PasswordsTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PasswordsTable _passwords;
  $PasswordsTable get passwords => _passwords ??= $PasswordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [passwords];
}
