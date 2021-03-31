import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:storage_infomation/repository/KeyRepository.dart';
import 'package:storage_infomation/repository/PasswordRepository.dart';

import 'PasswordHomepage.dart';

class ViewPassword extends StatefulWidget {
  final keyRepo = GetIt.I.get<KeyRepository>();
  final PasswordRepository passwordRepo;
  final Password password;

  ViewPassword({Key key, this.password, this.passwordRepo}) : super(key: key);

  @override
  _ViewPasswordState createState() => _ViewPasswordState(password, passwordRepo);
}

class _ViewPasswordState extends State<ViewPassword> {
  final Password _password;
  final PasswordRepository _passwordRepo;
  var sizeIcon = 0.28;

  _ViewPasswordState(this._password, this._passwordRepo);

  TextEditingController masterPassController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 64, color: Colors.white),
    Icon(Icons.add, size: 64, color: Colors.white),
    Icon(Icons.access_alarms, size: 64, color: Colors.white),
    Icon(Icons.ac_unit, size: 64, color: Colors.white),
    Icon(Icons.accessible, size: 64, color: Colors.white),
    Icon(Icons.account_balance, size: 64, color: Colors.white),
    Icon(Icons.add_circle_outline, size: 64, color: Colors.white),
    Icon(Icons.airline_seat_individual_suite, size: 64, color: Colors.white),
    Icon(Icons.arrow_drop_down_circle, size: 64, color: Colors.white),
    Icon(Icons.assessment, size: 64, color: Colors.white),
  ];

  List<String> iconNames = [
    "Icon 1",
    "Icon 2",
    "Icon 3",
    "Icon 4",
    "Icon 5",
    "Icon 6",
    "Icon 7",
    "Icon 8",
    "Icon 9",
    "Icon 10",
  ];
  bool decrypt = false;
  String decrypted = "**************";
  Color color;
  int index;

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    color = hexToColor(_password.color);
    index = iconNames.indexOf(_password.icon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: size.height * sizeIcon,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    icons[index],
                    SizedBox(
                      height: 12,
                    ),
                    Text(_password.appName,
                        style: TextStyle(
                            fontFamily: "Title",
                            fontSize: 32,
                            color: Colors.white)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Username",
                            style: TextStyle(fontFamily: 'Title', fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 270,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _password.userName,
                              style: TextStyle(
                                fontFamily: 'Subtitle',
                                fontSize: 20,
                                // color: Colors.black54
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () async {
                        Clipboard.setData(new ClipboardData(text: _password.userName));
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Copied Username to Clipboard!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Password",
                            style: TextStyle(fontFamily: 'Title', fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 270,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              decrypt ? _password.password : decrypted,
                              style: TextStyle(
                                fontFamily: 'Subtitle',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          decrypt = !decrypt;
                        });
                      },
                      icon: decrypt ? Icon(Icons.lock_open) : Icon(Icons.lock),
                    ),
                    IconButton(
                      icon: decrypt ? Icon(Icons.copy) : Icon(Icons.data_usage),
                      onPressed: () async {
                        if (decrypt) {
                          Clipboard.setData(new ClipboardData(text: decrypted));
                          scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Copied password Clipboard!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please unlock account to coppy!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Url",
                            style: TextStyle(fontFamily: 'Title', fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 270,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _password.url,
                              style: TextStyle(
                                fontFamily: 'Subtitle',
                                fontSize: 20,
                                // color: Colors.black54
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () async {
                        Clipboard.setData(new ClipboardData(text: _password.url));
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Copied Url to Clipboard!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Note",
                            style: TextStyle(fontFamily: 'Title', fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 270,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _password.note,
                              style: TextStyle(
                                fontFamily: 'Subtitle',
                                fontSize: 20
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () async {
                        Clipboard.setData(
                            new ClipboardData(text: _password.note));
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Copied Note to Clipboard!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 50,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: Colors.greenAccent,
                      child: Text(
                        "Update account",
                        style: TextStyle(color: Colors.white, fontFamily: "Title", fontSize: 20),
                      ),
                      onPressed: () => null,
                    ),
                    SizedBox(width: 15),
                    MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 50,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: Color(0xff5153FF),
                      child: Text(
                        "Delete account",
                        style: TextStyle(color: Colors.white, fontFamily: "Title", fontSize: 20),
                      ),
                      onPressed: () => _onAlertButtonDelete(context),
                    ),
                    SizedBox(width: 10),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onAlertButtonDelete(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you sure want to delete this account?",
      desc: "This cannot be undone.",
      buttons: [
        DialogButton(
          child: Text(
            "Confirm",
            style: TextStyle(fontFamily: "Title", color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            _passwordRepo.removePassword(_password);
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new PasswordHomepage(passwordRepo: _passwordRepo)
                )
            );
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(fontFamily: "Title", color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();
  }
}
