import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:storage_infomation/pages/GreetingsPage.dart';
import 'package:storage_infomation/pages/PasswordHomepage.dart';
import 'package:storage_infomation/repository/KeyRepository.dart';
import 'package:storage_infomation/repository/PasswordRepository.dart';
const loginTypePrefsKey = "login_type";

void main() {
  _prepareDI();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String setPassword = "";
  bool loading = true;
  Color primaryColor = Color(0xff5153FF);

  Future checkFirstSeen() async {
    final storage = new FlutterSecureStorage();
    setPassword = await storage.read(key: 'setPassword') ?? '';

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
            : setPassword == "setup_success" ? PasswordHomepage() : GreetingsPage(),
      ),
    );
  }
}

_prepareDI() {
  final getIt = GetIt.I;
  getIt.registerSingleton<PasswordRepository>(RsaPasswordRepository());
  getIt.registerSingleton<KeyRepository>(RsaKeysRepository());
}