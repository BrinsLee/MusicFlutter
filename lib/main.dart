import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_flutter/common/provider/providerSetup.dart';
import 'package:music_flutter/common/theme/darkThemeModel.dart';
import 'package:music_flutter/common/theme/themeModel.dart';
import 'package:music_flutter/common/utils/screen_util.dart';
import 'package:music_flutter/common/widgets/bottomTabNavigation.dart';
import 'package:music_flutter/common/widgets/widgets.dart';
import 'package:music_flutter/pages/splash/splashPage.dart';
import 'package:music_flutter/pages/undefined/undefined.dart';
import 'package:provider/provider.dart';
import 'package:music_flutter/common/routes/router.dart' as router;

String? currentThemeID;
String? currentDarkThemeID;
Color? lightAccent;
Color? darkAccent;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  currentThemeID = "kLFrost White";
  currentDarkThemeID = "KDMaterial Dark";
  runZoned(() {
    runApp(RestartWidget(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>(
              create: (context) =>
                  ThemeModel(themes[currentThemeID], lightAccent)),
          ChangeNotifierProvider<DarkThemeModel>(
            create: (context) =>
                DarkThemeModel(darkThemes[currentDarkThemeID!], darkAccent),
          ),
          ...providers,
        ],
        child: MyApp(),
      ),
    ));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (setting) => MaterialPageRoute(
        builder: (context) => UndefinedPage(name: setting.name),
      ),
      theme: Provider.of<ThemeModel>(context).currentTheme,
      darkTheme: Provider.of<DarkThemeModel>(context).currentTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
    ScreenUtil.init(width: 360, height: 920, allowFontScaling: true);
    return BottomTabNavigation();
  }
}
