import 'dart:async';

import 'package:storage_infomation/database/Database.dart';
import 'package:storage_infomation/model/PasswordModel.dart';

class PasswordBloc {
  PasswordBloc() {
    getPasswords();
  }
  final _passwordController = StreamController<List<Password>>.broadcast();
  get passwords => _passwordController.stream;

  dispose() {
    _passwordController.close();
  }

  getPasswords() async {
    _passwordController.sink.add(await DBProvider.db.getAllPasswords());
  }

  getPasswordByAppName(String appName) async {
    return await DBProvider.db.getPasswordByAppName(appName);
  }

  add(Password password) {
    DBProvider.db.newPassword(password);
    getPasswords();
  }
  update(Password password) {
    DBProvider.db.updatePassword(password);
    getPasswords();
  }
  delete(int id) {
    DBProvider.db.deletePassword(id);
    getPasswords();
  }

  deleteAll() {
    DBProvider.db.deleteAll();
    getPasswords();
  }
}
