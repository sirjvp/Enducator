import 'dart:io';

import 'package:double_back_to_close/double_back_to_close.dart';
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
      // home: DoubleBack(
      //     message:"Press back again to close",
      //     child: Home()),
      // home: AnimatedSplashScreen(splash: Image.asset("assets/images/logo.png", height: 150), nextScreen: Login.routeName),
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
        AddDevice.routeName: (context) => AddDevice(),
        DetailDevice.routeName: (context) => DetailDevice(),
        Setting.routeName: (context) => Setting(),
        EditProfile.routeName: (context) => EditProfile(),
        ReportDetail.routeName: (context) => ReportDetail(),
      },
    );
  }
}