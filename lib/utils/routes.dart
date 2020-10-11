import 'package:flutter/material.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/inbound/inbound_screen.dart';
import 'package:msi_app/screens/inventory_dispatch/inventory_dispatch_header_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_detail/inventory_dispatch_detail_screen.dart';
import 'package:msi_app/screens/list_put_away_submited/list_put_away_submited_screen.dart';
import 'package:msi_app/screens/list_receipt_from_vendor/list_receipt_from_vendor_screen.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/screens/outbound/outbound_screen.dart';
import 'package:msi_app/screens/pick_item_bin/pick_list_bin_screen.dart';
import 'package:msi_app/screens/pick_item_receive/pick_item_receive_screen.dart';
import 'package:msi_app/screens/picker_pick/picker_pick_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/screens/put_away/put_away_screen.dart';
import 'package:msi_app/screens/receipt_check/receipt_check_screen.dart';
import 'package:msi_app/screens/receipt_detail/receipt_detail_screen.dart';
import 'package:msi_app/screens/receipt_vendor/receipt_vendor_screen.dart';
import 'package:msi_app/screens/return_outlet/return_outlet_screen.dart';
import 'package:msi_app/screens/return_vendor/return_vendor_screen.dart';
import 'package:msi_app/screens/splash/splash_screen.dart';
import 'package:msi_app/screens/staging_batch/staging_batch_screen.dart';
import 'package:msi_app/screens/staging_confirm/staging_confirm_screen.dart';
import 'package:msi_app/screens/staging_item/staging_item_screen.dart';
import 'package:msi_app/screens/stock_counting/stock_counting_screen.dart';
import 'package:msi_app/screens/stock_inquiry/stock_inquiry_screen.dart';

final String initialRoute = SplashScreen.routeName;

final Map<String, WidgetBuilder> routes = {
  // GENERAL
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),

  // SUB MENU
  InboundScreen.routeName: (context) => InboundScreen(),
  OutboundScreen.routeName: (context) => OutboundScreen(),
  ProductionScreen.routeName: (context) => ProductionScreen(),
  StockCountingScreen.routeName: (context) => StockCountingScreen(),
  StockInquiryScreen.routeName: (context) => StockInquiryScreen(),

  // INBOUND TRANSACTION
  // Receipt From Vendor
  ReceiptVendorScreen.routeName: (context) => ReceiptVendorScreen(),
  ReceiptDetailScreen.routeName: (context) => ReceiptDetailScreen(),
  ReceiptCheckScreen.routeName: (context) => ReceiptCheckScreen(),
  ListReceiptFromVendorScreen.routeName: (context) =>
      ListReceiptFromVendorScreen(),

  // Put Away
  PutAwayScreen.routeName: (context) => PutAwayScreen(),
  StagingItemScreen.routeName: (context) => StagingItemScreen(),
  StagingBatchScreen.routeName: (context) => StagingBatchScreen(),
  StagingConfirmScreen.routeName: (context) => StagingConfirmScreen(),
  ListPutAwaySubmitedScreen.routeName: (context) => ListPutAwaySubmitedScreen(),

  // Return From Outlet
  ReturnOutletScreen.routeName: (context) => ReturnOutletScreen(),

  // OUTBOUND TRANSCATION
  // Picker Pick List
  PickerPickScreen.routeName: (context) => PickerPickScreen(),
  PickItemReceiveScreen.routeName: (context) => PickItemReceiveScreen(),
  PickListBinScreen.routeName: (context) => PickListBinScreen(),

  // Inventory Dispatch
  InventoryDispatchHeaderScreen.routeName: (context) =>
      InventoryDispatchHeaderScreen(),
  InventoryDispatchDetailScreen.routeName: (context) =>
      InventoryDispatchDetailScreen(),

  // Return To Vendor
  ReturnVendorScreen.routeName: (context) => ReturnVendorScreen(),
};
