import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:storage_infomation/bloc/PasswordBloc.dart';
import 'package:storage_infomation/database/Database.dart';
import 'package:storage_infomation/model/PasswordModel.dart';
import 'package:storage_infomation/pages/ViewPasswordPage.dart';

import 'AddPasswordPage.dart';
import 'MainDrawer.dart';
import 'SettingsPage.dart';

class PasswordHomepage extends StatefulWidget {
  @override
  _PasswordHomepageState createState() => _PasswordHomepageState();

  Brightness brigntness = Brightness.light;

  PasswordHomepage({this.brigntness});
}

class _PasswordHomepageState extends State<PasswordHomepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

  final bloc = PasswordBloc();

  @override
  void dispose() {
    bloc.dispose();
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
                      onPressed: () => _scaffoldKey.currentState.openDrawer()
                    ),
                    Text(
                      "Cipherly",
                      style: TextStyle(fontFamily: "Title", fontSize: 32, color: primaryColor),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => SettingsPage()));
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
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
            ),
            padding: EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 243, 243, 1),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.black87,),
                    hintText: "Search you're looking for",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Password>>(
              stream: bloc.passwords,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Password password = snapshot.data[index];
                        int i = 0;
                        i = iconNames.indexOf(password.icon);
                        Color color = hexToColor(password.color);
                        return Dismissible(
                          key: ObjectKey(password.id),
                          onDismissed: (direction) {
                            var item = password;
                            //To delete
                            DBProvider.db.deletePassword(item.id);
                            setState(() {
                              snapshot.data.removeAt(index);
                            });
                            //To show a snackbar with the UNDO button
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Password deleted"),
                                action: SnackBarAction(
                                    label: "UNDO",
                                    onPressed: () {
                                      DBProvider.db.newPassword(item);
                                      setState(() {
                                        snapshot.data.insert(index, item);
                                      });
                                    })));
                          },
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ViewPassword(
                                            password: password,
                                          )));
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
                                  child: CircleAvatar(
                                      backgroundColor: color, child: icons[i])),
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
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Passwords Saved. \nClick \"+\" button to add a password",
                        textAlign: TextAlign.center,
                        // style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 50.0, left: 300),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(Icons.add),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => AddPassword()));
            },
          ),
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }
}
