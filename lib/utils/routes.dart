import 'package:flutter/cupertino.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/inbound/inbound_screen.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/screens/outbound/outbound_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/screens/splash/splash_screen.dart';
import 'package:msi_app/screens/stock_counting/stock_counting_screen.dart';
import 'package:msi_app/screens/stock_inquiry/stock_inquiry_screen.dart';

final String initialRoute = SplashScreen.routeName;

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  InboundScreen.routeName: (context) => InboundScreen(),
  OutboundScreen.routeName: (context) => OutboundScreen(),
  ProductionScreen.routeName: (context) => ProductionScreen(),
  StockCountingScreen.routeName: (context) => StockCountingScreen(),
  StockInquiryScreen.routeName: (context) => StockInquiryScreen(),
};
