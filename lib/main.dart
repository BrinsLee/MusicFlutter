import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:music_flutter/common/provider/providerSetup.dart';
import 'package:music_flutter/common/theme/darkThemeModel.dart';
import 'package:music_flutter/common/theme/themeModel.dart';
import 'package:music_flutter/common/utils/utils.dart';
import 'package:music_flutter/common/widgets/bottom_tab_navigation.dart';
import 'package:music_flutter/common/widgets/widgets.dart';
import 'package:music_flutter/pages/splash/splashPage.dart';
import 'package:music_flutter/pages/undefined/undefined.dart';
import 'package:provider/provider.dart';
import 'package:music_flutter/common/routes/router.dart' as router;

String currentThemeID;
String currentDarkThemeID;
Color lightAccent;
Color darkAccent;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  currentThemeID = "kLFrost White";
  currentDarkThemeID = "KDMaterial Dark";
  StorageUtil.init();
  await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
  if (useWhiteForeground(Colors.white)) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
  runZoned(() {
    runApp(RestartWidget(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>(
              create: (context) =>
                  ThemeModel(themes[currentThemeID], lightAccent)),
          ChangeNotifierProvider<DarkThemeModel>(
            create: (context) =>
                DarkThemeModel(darkThemes[currentDarkThemeID], darkAccent),
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
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        onUnknownRoute: (setting) => MaterialPageRoute(
          builder: (context) => UndefinedPage(name: setting.name),
        ),
        theme: Provider.of<ThemeModel>(context).currentTheme,
        darkTheme: Provider.of<DarkThemeModel>(context).currentTheme,
        home: MyHomePage(),
      ),
      designSize: Size(360, 920),
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
    return BottomTabNavigation();
  }
}
