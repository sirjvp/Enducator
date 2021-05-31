import 'dart:io';

import 'package:electricity_calc/shared/shared.dart';
import 'package:electricity_calc/ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void enablePlatformOverrideForDesktop(){
  if(!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)){
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async{
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Electricity Calculator",
      theme: MyTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        Splash.routeName: (context) => Splash(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        Home.routeName: (context) => Home(),
        DetailDevice.routeName: (context) => DetailDevice(),
        Setting.routeName: (context) => Setting(),
        EditProfile.routeName: (context) => EditProfile(),
      },
    );
  }
}