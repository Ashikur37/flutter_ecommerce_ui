import 'package:commerce/theme.dart';
import 'package:flutter/material.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/routes.dart';
import 'package:commerce/screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: SplashScreen.routeName,
      // routes: routes,
    );
  }
}
