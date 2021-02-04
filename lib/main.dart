import 'dart:io';

import 'package:weather/global.dart';
import 'package:weather/model/temp_status.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/theme/theme.dart';
import 'package:weather/theme/theme_notifier.dart';
import 'package:weather/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations( Device.get().isPhone ?
  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,] :
  [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]
  ).then((_) async {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
  });
  SharedPreferences.getInstance().then((prefs) {
    Global.darkMode = prefs.getBool('darkMode') ?? false;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(Global.darkMode ? darkTheme : lightTheme),
        child: MyApp(),
      ),
    );
  });
  SharedPref sharedPref = SharedPref();
  var status =  await sharedPref.read("status");
  if(status == null){
    TempStatus tempStatus = TempStatus(false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false);
    sharedPref.save("status", tempStatus.toJson());
  }
}



class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Key key = new UniqueKey();

  void restartApp() {
    this.setState(() {
      key = new UniqueKey();
    });
  }
  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      key: key,
      title: 'Empty Project',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      routes: routes,
    );
  }

}
class Routes {
  static const String SPLASH = "/";
  static const String HOME = "/home";
  static const String SETTING = "/setting";
}

enum DayImageAnimationStatus{
  RiseSet,SetRise
}
