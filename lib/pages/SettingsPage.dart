import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storage_infomation/pages/PasswordHomepage.dart';
import 'package:storage_infomation/repository/KeyRepository.dart';
import 'package:storage_infomation/repository/PasswordRepository.dart';

class SettingsPage extends StatefulWidget {
  final keyRepository = GetIt.I.get<KeyRepository>();
  final PasswordRepository passwordRepo;

  SettingsPage({this.passwordRepo});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController currentMasterPassCtl = TextEditingController();
  TextEditingController newMasterPassCtl = TextEditingController();

  @override
  void initState() {
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
                      hintText: "Current Master Pass",
                      hintStyle: TextStyle(fontFamily: "Subtitle"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14))),
                  controller: currentMasterPassCtl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 4.0, top: 4.0),
                child: TextField(
                  obscureText: true,
                  maxLength: 32,
                  decoration: InputDecoration(
                      hintText: "New Master Password",
                      hintStyle: TextStyle(fontFamily: "Subtitle"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14))),
                  controller: newMasterPassCtl,
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                try {
                  final keyPair = await widget.keyRepository.retrievePasswordEncryptedKeys(currentMasterPassCtl.text);
                  PasswordRepository passRepo = GetIt.I.get<PasswordRepository>();
                  (passRepo as RsaPasswordRepository).setKeys(keyPair);
                  widget.keyRepository.clearKeys().whenComplete(() => {
                    widget.keyRepository.storePasswordEncryptedKeys(newMasterPassCtl.text, keyPair),
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (BuildContext context) => new PasswordHomepage(passwordRepo: passRepo))
                  )
                  });
                } catch (e) {
                  Navigator.of(context).pop();
                  currentMasterPassCtl.clear();
                  newMasterPassCtl.clear();
                  final snackBar = SnackBar(
                    content: Text(
                      'Wrong Master Password',
                      style: TextStyle(fontFamily: "Subtitle"),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackBar);
                }
              },
              child: Text("DONE"),
            )
          ],
        );
      },
    );
  }
}
