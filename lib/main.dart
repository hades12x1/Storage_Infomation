import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:storage_infomation/pages/GreetingsPage.dart';
import 'package:storage_infomation/pages/PasswordHomepage.dart';
const loginTypePrefsKey = "login_type";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int launch = 0;
  bool loading = true;
  Color primaryColor = Color(0xff5153FF);

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    launch = prefs.getInt("launch") ?? 0;

    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';

    if (prefs.getInt('primaryColor') == null) {
      await prefs.setInt('primaryColor', 0);
    }

    if (launch == 0 && masterPass == '') {
      await prefs.setInt('launch', launch + 1);
      await prefs.setInt('primaryColor', 0);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        fontFamily: "Title",
        primaryColor: primaryColor,
        accentColor: Color(0xff0029cb),
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cipherly',
        theme: theme,
        home: loading
            ? Center(child: CircularProgressIndicator())
            : launch == 0 ? GreetingsPage() : PasswordHomepage(),
      ),
    );
  }
}
