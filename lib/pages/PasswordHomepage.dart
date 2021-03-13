import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storage_infomation/pages/ViewPasswordPage.dart';
import 'package:storage_infomation/repository/KeyRepository.dart';
import 'package:storage_infomation/repository/PasswordRepository.dart';

import 'AddPasswordPage.dart';
import 'MainDrawer.dart';
import 'SettingsPage.dart';

class PasswordHomepage extends StatefulWidget {
  @override
  _PasswordHomepageState createState() => _PasswordHomepageState();
  final keyRepository = GetIt.I.get<KeyRepository>();
  final PasswordRepository passwordRepository;

  PasswordHomepage({this.passwordRepository});
}

class _PasswordHomepageState extends State<PasswordHomepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController masterPassController = TextEditingController();
  var passwords = List<Password>();
  var passwordOnRam = List<Password>();

  int pickedIcon;

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 28, color: Colors.white),
    Icon(Icons.add, size: 28, color: Colors.white),
    Icon(Icons.access_alarms, size: 28, color: Colors.white),
    Icon(Icons.ac_unit, size: 28, color: Colors.white),
    Icon(Icons.accessible, size: 28, color: Colors.white),
    Icon(Icons.account_balance, size: 28, color: Colors.white),
    Icon(Icons.add_circle_outline, size: 28, color: Colors.white),
    Icon(Icons.airline_seat_individual_suite, size: 28, color: Colors.white),
    Icon(Icons.arrow_drop_down_circle, size: 28, color: Colors.white),
    Icon(Icons.assessment, size: 28, color: Colors.white),
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

  @override
  void initState() {
    if (widget.passwordRepository == null) {
      super.initState();
      _buildShowDialogBox(context);
    } else {
      super.initState();
    }
    widget.passwordRepository.retrievePasswords().then((value) {
      setState(() {
        passwords.addAll(value);
        passwordOnRam.addAll(value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: _scaffoldKey,
      drawer: new MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.menu_outlined,
                        color: primaryColor,
                      ),
                      onPressed: () => _scaffoldKey.currentState.openDrawer()),
                  Text(
                    "Cipherly",
                    style: TextStyle(
                        fontFamily: "Title", fontSize: 32, color: primaryColor),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SettingsPage()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(20))),
            padding: EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 243, 243, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.black87),
                      hintText: "Search you're looking for",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      if (text.isEmpty) {
                        widget.passwordRepository.retrievePasswords().then((value) {
                          passwords.addAll(value);
                        });
                      } else {
                        passwords = passwordOnRam.where((element) {
                          var appName = element.appName.toLowerCase();
                          return appName.contains(text);
                        }).toList();
                      }
                    });
                  }),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: passwords.length,
                itemBuilder: (BuildContext context, int index) {
                  return _listPassword(index);
                },
              )),
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 50.0, left: 300),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            child: Icon(Icons.add_rounded),
            backgroundColor: primaryColor,
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => AddPassword(passwordRepo: widget.passwordRepository)));
            },
          ),
        ),
      ),
    );
  }

  _listPassword(index) {
    Password password = passwords[index];
    int i = 0;
    i = iconNames.indexOf(password.icon);
    Color color = hexToColor(password.color);
    return Dismissible(
      key: ObjectKey(password.id),
      onDismissed: (direction) {
        var item = password;
        //To delete
        widget.passwordRepository.removePassword(item);
        setState(() {
          passwords.removeAt(index);
        });
        //To show a snackbar with the UNDO button
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Password deleted"),
            action: SnackBarAction(
                label: "UNDO",
                onPressed: () {
                  widget.passwordRepository.addEntry(item);
                  setState(() {
                    passwords.insert(index, item);
                  });
                }))
        );
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => ViewPassword(password: password)));
        },
        child: ListTile(
          title: Text(
            password.appName,
            style: TextStyle(
              fontFamily: 'Title',
            ),
          ),
          leading: Container(
              height: 48,
              width: 48,
              child: CircleAvatar(backgroundColor: color, child: icons[i])),
          subtitle: password.userName != ""
              ? Text(
            password.userName,
            style: TextStyle(
              fontFamily: 'Subtitle',
            ),
          )
              : Text(
            "No username specified",
            style: TextStyle(
              fontFamily: 'Subtitle',
            ),
          ),
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }

  _buildShowDialogBox(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 30));
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Enter Master Password"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "To decrypt the password enter your master password:",
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
                onPressed: () async {
                  PasswordHomepage passHomePage;
                  try {
                    final keyPair = await widget.keyRepository.retrievePasswordEncryptedKeys(masterPassController.text);
                    final _passwordRepository = GetIt.I.get<PasswordRepository>();
                    (_passwordRepository as RsaPasswordRepository).setKeys(keyPair);
                    passHomePage = new PasswordHomepage(passwordRepository: _passwordRepository);
                  } catch(e) {
                    passHomePage = new PasswordHomepage();
                  } finally {
                    masterPassController.clear();
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => passHomePage));
                  }
                },
                child: Text("DONE"),
              )
            ],
          )
        );
      },
    );
  }
}
