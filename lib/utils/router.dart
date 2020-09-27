import 'package:flutter/cupertino.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/screens/splash/splash_screen.dart';

final String initialRoute = SplashScreen.routeName;

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
