import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:storage_infomation/repository/KeyRepository.dart';
import 'package:storage_infomation/repository/PasswordRepository.dart';

class ViewPassword extends StatefulWidget {
  final keyRepo = GetIt.I.get<KeyRepository>();
  final PasswordRepository passwordRepo;
  final Password password;

  ViewPassword({Key key, this.password, this.passwordRepo}) : super(key: key);

  @override
  _ViewPasswordState createState() => _ViewPasswordState(password);
}

class _ViewPasswordState extends State<ViewPassword> {
  final Password password;
  var sizeIcon = 0.28;

  _ViewPasswordState(this.password);

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

  Future<String> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    return masterPass;
  }

  @override
  void initState() {
    print(password.color);
    color = hexToColor(password.color);
    index = iconNames.indexOf(password.icon);
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
                    Text(password.appName,
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
                              password.userName,
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
                        Clipboard.setData(new ClipboardData(text: password.userName));
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
                              decrypt ? password.password : decrypted,
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
                              password.url,
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
                        Clipboard.setData(new ClipboardData(text: password.url));
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
                              password.note,
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
                            new ClipboardData(text: password.note));
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
                      color: Colors.lightBlueAccent,
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
                      color: Colors.redAccent,
                      child: Text(
                        "Delete account",
                        style: TextStyle(color: Colors.white, fontFamily: "Title", fontSize: 20),
                      ),
                      onPressed: () => null,
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
}
