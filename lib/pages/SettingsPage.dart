import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_infomation/pages/SetMasterPassword.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SharedPreferences prefs;
  TextEditingController masterPassController = TextEditingController();

  openSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    openSharedPreferences();
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  Color pickedColor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    Color primaryColor = Theme
        .of(context)
        .primaryColor;

    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Text("Settings",
                    style: TextStyle(
                        fontFamily: "Title",
                        fontSize: 32,
                        color: primaryColor))),
          ),
          InkWell(
            onTap: () {
              buildShowDialogBox(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => SetMasterPassword()));
            },
            child: ListTile(
              title: Text(
                "Master Password",
                style: TextStyle(
                  fontFamily: 'Title',
                ),
              ),
              subtitle: Text(
                "Change your Master Password",
                style: TextStyle(
                  fontFamily: 'Subtitle',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future buildShowDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Master Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "To renew master password, please enter current master password:",
                style: TextStyle(fontFamily: 'Subtitle'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  maxLength: 32,
                  decoration: InputDecoration(
                      hintText: "Master Pass",
                      hintStyle: TextStyle(fontFamily: "Subtitle"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  controller: masterPassController,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                getMasterPass().then((value) {
                    if(value == masterPassController.text) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SetMasterPassword()));
                    } else {
                      Navigator.of(context).pop();
                      final snackBar = SnackBar(
                        content: Text(
                          'Wrong Master Password',
                          style: TextStyle(fontFamily: "Subtitle"),
                        ),
                      );
                      scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                });
              },
              child: Text("DONE"),
            )
          ],
        );
      },
    );
  }

  Future<String> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: 'master') ?? '';
  }
}
