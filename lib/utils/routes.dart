import 'package:flutter/cupertino.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/inbound/inbound_screen.dart';
import 'package:msi_app/screens/inventory_dispatch/inventory_dispatch_screen.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/screens/outbound/outbound_screen.dart';
import 'package:msi_app/screens/picker_pick/picker_pick_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/screens/put_away/put_away_screen.dart';
import 'package:msi_app/screens/receipt_vendor/receipt_vendor_screen.dart';
import 'package:msi_app/screens/return_outlet/return_outlet_screen.dart';
import 'package:msi_app/screens/return_vendor/return_vendor_screen.dart';
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
  ReceiptVendorScreen.routeName: (context) => ReceiptVendorScreen(),
  PutAwayScreen.routeName: (context) => PutAwayScreen(),
  ReturnOutletScreen.routeName: (context) => ReturnOutletScreen(),
  PickerPickScreen.routeName: (context) => PickerPickScreen(),
  InventoryDispatchScreen.routeName: (context) => InventoryDispatchScreen(),
  ReturnVendorScreen.routeName: (context) => ReturnVendorScreen(),
};
