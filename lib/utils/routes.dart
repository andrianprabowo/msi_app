import 'package:flutter/material.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch/inventory_dispatch_batch_screen.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_rtv/inventory_dispatch_batch_rtv_screen.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_so/inventory_dispatch_batch_so_screen.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/inbound/inbound_screen.dart';
import 'package:msi_app/screens/inbound_sub_1/inbound_sub_1_screen.dart';
import 'package:msi_app/screens/inbound_sub_2/inbound_sub_2_screen.dart';
import 'package:msi_app/screens/inventory_dispatch/inventory_dispatch_header_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_bin/inventory_dispatch_bin_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_bin_rtv/inventory_dispatch_bin_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_bin_so/inventory_dispatch_bin_so_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_check/inventory_dispatch_check_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_check_rtv/inventory_dispatch_check_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_check_so/inventory_dispatch_check_so_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_detail/inventory_dispatch_detail_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_detail_rtv/inventory_dispatch_detail_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_detail_so/inventory_dispatch_detail_so_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item/inventory_dispatch_item_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item_rtv/inventory_dispatch_item_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item_so/inventory_dispatch_item_so_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_rtv/inventory_dispatch_header_screen_rtv.dart';
import 'package:msi_app/screens/inventory_dispatch_so/inventory_dispatch_header_screen_so.dart';
import 'package:msi_app/screens/list_put_away_submited/list_put_away_submited_screen.dart';
import 'package:msi_app/screens/list_receipt_from_vendor/list_receipt_from_vendor_screen.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/screens/outbound/outbound_screen.dart';
import 'package:msi_app/screens/outbound_sub_1/outbound_sub_1_screen.dart';
import 'package:msi_app/screens/outbound_sub_2/outbound_sub_2_screen.dart';
import 'package:msi_app/screens/outbound_sub_3/outbound_sub_3_screen.dart';
import 'package:msi_app/screens/pick_check/pick_check_screen.dart';
import 'package:msi_app/screens/pick_check_rtv/pick_check_rtv_screen.dart';
import 'package:msi_app/screens/pick_check_so/pick_check_so_screen.dart';
import 'package:msi_app/screens/pick_item_batch/pick_item_batch_screen.dart';
import 'package:msi_app/screens/pick_item_batch_rtv/pick_item_batch_rtv_screen.dart';
import 'package:msi_app/screens/pick_item_batch_so/pick_item_batch_so_screen.dart';
import 'package:msi_app/screens/pick_item_bin/pick_list_bin_screen.dart';
import 'package:msi_app/screens/pick_item_bin_rtv/pick_list_bin_rtv_screen.dart';
import 'package:msi_app/screens/pick_item_bin_so/pick_list_bin_so_screen.dart';
import 'package:msi_app/screens/pick_item_receive/pick_item_receive_screen.dart';
import 'package:msi_app/screens/pick_item_receive_rtv/pick_item_receive_rtv_screen.dart';
import 'package:msi_app/screens/pick_item_receive_so/pick_item_receive_so_screen.dart';
import 'package:msi_app/screens/picker_pick/picker_pick_screen.dart';
import 'package:msi_app/screens/picker_pick_rtv/picker_pick_rtv_screen.dart';
import 'package:msi_app/screens/picker_pick_so/picker_pick_so_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/screens/put_away/put_away_screen.dart';
import 'package:msi_app/screens/put_away_rfo/put_away_rfo_screen.dart';
import 'package:msi_app/screens/receipt_check/receipt_check_screen.dart';
import 'package:msi_app/screens/receipt_check_rfo/receipt_check_rfo_screen.dart';
import 'package:msi_app/screens/receipt_detail/receipt_detail_screen.dart';
import 'package:msi_app/screens/receipt_detail_rfo/receipt_detail_rfo_screen.dart';
import 'package:msi_app/screens/receipt_vendor/receipt_vendor_screen.dart';
import 'package:msi_app/screens/receipt_vendor_rfo/receipt_vendor_rfo_screen.dart';
import 'package:msi_app/screens/return_outlet/return_outlet_screen.dart';
import 'package:msi_app/screens/return_vendor/return_vendor_screen.dart';
import 'package:msi_app/screens/splash/splash_screen.dart';
import 'package:msi_app/screens/staging_batch/staging_batch_screen.dart';
import 'package:msi_app/screens/staging_batch_rfo/staging_batch_rfo_screen.dart';
import 'package:msi_app/screens/staging_check/staging_check_screen.dart';
import 'package:msi_app/screens/staging_check_rfo/staging_check_rfo_screen.dart';
import 'package:msi_app/screens/staging_item/staging_item_screen.dart';
import 'package:msi_app/screens/staging_item_rfo/staging_item_rfo_screen.dart';
import 'package:msi_app/screens/stock_counting/stock_counting_screen.dart';
import 'package:msi_app/screens/stock_counting_header/stock_counting_header_screen.dart';
import 'package:msi_app/screens/stock_inquiry/stock_inquiry_screen.dart';
import 'package:msi_app/screens/storage_bin_item/storage_bin_item_screen.dart';
import 'package:msi_app/screens/storage_bin_item_rfo/storage_bin_item_rfo_screen.dart';

final String initialRoute = SplashScreen.routeName;

final Map<String, WidgetBuilder> routes = {
  // GENERAL
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),

  // SUB MENU
  InboundScreen.routeName: (context) => InboundScreen(),
  InboundSub1Screen.routeName: (context) => InboundSub1Screen(),
  InboundSub2Screen.routeName: (context) => InboundSub2Screen(),
  OutboundScreen.routeName: (context) => OutboundScreen(),
  OutboundSub1Screen.routeName: (context) => OutboundSub1Screen(),
  OutboundSub2Screen.routeName: (context) => OutboundSub2Screen(),
  OutboundSub3Screen.routeName: (context) => OutboundSub3Screen(),
  ProductionScreen.routeName: (context) => ProductionScreen(),
  StockCountingScreen.routeName: (context) => StockCountingScreen(),
  StockInquiryScreen.routeName: (context) => StockInquiryScreen(),

  // INBOUND TRANSACTION
  // Receipt From Vendor
  ReceiptVendorScreen.routeName: (context) => ReceiptVendorScreen(),
  ReceiptVendorRfoScreen.routeName: (context) => ReceiptVendorRfoScreen(),
  ReceiptDetailScreen.routeName: (context) => ReceiptDetailScreen(),
  ReceiptDetailRfoScreen.routeName: (context) => ReceiptDetailRfoScreen(),
  ReceiptCheckScreen.routeName: (context) => ReceiptCheckScreen(),
  ReceiptCheckRfoScreen.routeName: (context) => ReceiptCheckRfoScreen(),
  ListReceiptFromVendorScreen.routeName: (context) =>
      ListReceiptFromVendorScreen(),

  // Put Away
  PutAwayScreen.routeName: (context) => PutAwayScreen(),
  PutAwayRfoScreen.routeName: (context) => PutAwayRfoScreen(),
  StagingItemScreen.routeName: (context) => StagingItemScreen(),
  StagingItemRfoScreen.routeName: (context) => StagingItemRfoScreen(),
  StagingBatchScreen.routeName: (context) => StagingBatchScreen(),
  StagingBatchRfoScreen.routeName: (context) => StagingBatchRfoScreen(),
  StorageBinItemScreen.routeName: (context) => StorageBinItemScreen(),
  StorageBinItemRfoScreen.routeName: (context) => StorageBinItemRfoScreen(),
  StagingCheckScreen.routeName: (context) => StagingCheckScreen(),
  StagingCheckRfoScreen.routeName: (context) => StagingCheckRfoScreen(),
  ListPutAwaySubmitedScreen.routeName: (context) => ListPutAwaySubmitedScreen(),

  // Return From Outlet
  ReturnOutletScreen.routeName: (context) => ReturnOutletScreen(),

  // OUTBOUND TRANSCATION

  // Picker Pick List
  PickerPickScreen.routeName: (context) => PickerPickScreen(),
  PickItemReceiveScreen.routeName: (context) => PickItemReceiveScreen(),
  PickListBinScreen.routeName: (context) => PickListBinScreen(),
  PickItemBatchScreen.routeName: (context) => PickItemBatchScreen(),
  PickCheckScreen.routeName: (context) => PickCheckScreen(),
  
  // Picker Pick List So
  PickerPickSoScreen.routeName: (context) => PickerPickSoScreen(),
  PickItemReceiveSoScreen.routeName: (context) => PickItemReceiveSoScreen(),
  PickListBinSoScreen.routeName: (context) => PickListBinSoScreen(),
  PickItemBatchSoScreen.routeName: (context) => PickItemBatchSoScreen(),
  PickCheckSoScreen.routeName: (context) => PickCheckSoScreen(),

  // Picker Pick List Rtv
  PickerPickRtvScreen.routeName: (context) => PickerPickRtvScreen(),
  PickItemReceiveRtvScreen.routeName: (context) => PickItemReceiveRtvScreen(),
  PickListBinRtvScreen.routeName: (context) => PickListBinRtvScreen(),
  PickItemBatchRtvScreen.routeName: (context) => PickItemBatchRtvScreen(),
  PickCheckRtvScreen.routeName: (context) => PickCheckRtvScreen(),

  // Inventory Dispatch
  InventoryDispatchHeaderScreen.routeName: (context) =>
      InventoryDispatchHeaderScreen(),
  InventoryDispatchDetailScreen.routeName: (context) =>
      InventoryDispatchDetailScreen(),
  InventoryDispatchItemScreen.routeName: (context) =>
      InventoryDispatchItemScreen(),
  InventoryDispatchBinScreen.routeName: (context) =>
      InventoryDispatchBinScreen(),
  InventoryDispatchBatchScreen.routeName: (context) =>
      InventoryDispatchBatchScreen(),
  InventoryDispatchCheckScreen.routeName: (context) =>
      InventoryDispatchCheckScreen(),

// Inventory Dispatch
  InventoryDispatchHeaderSoScreen.routeName: (context) =>
      InventoryDispatchHeaderSoScreen(),
  InventoryDispatchDetailSoScreen.routeName: (context) =>
      InventoryDispatchDetailSoScreen(),
  InventoryDispatchItemSoScreen.routeName: (context) =>
      InventoryDispatchItemSoScreen(),
  InventoryDispatchBinSoScreen.routeName: (context) =>
      InventoryDispatchBinSoScreen(),
  InventoryDispatchBatchSoScreen.routeName: (context) =>
      InventoryDispatchBatchSoScreen(),
  InventoryDispatchCheckSoScreen.routeName: (context) =>
      InventoryDispatchCheckSoScreen(),

      // Inventory Dispatch
  InventoryDispatchHeaderRtvScreen.routeName: (context) =>
      InventoryDispatchHeaderRtvScreen(),
  InventoryDispatchDetailRtvScreen.routeName: (context) =>
      InventoryDispatchDetailRtvScreen(),
  InventoryDispatchItemRtvScreen.routeName: (context) =>
      InventoryDispatchItemRtvScreen(),
  InventoryDispatchBinRtvScreen.routeName: (context) =>
      InventoryDispatchBinRtvScreen(),
  InventoryDispatchBatchRtvScreen.routeName: (context) =>
      InventoryDispatchBatchRtvScreen(),
  InventoryDispatchCheckRtvScreen.routeName: (context) =>
      InventoryDispatchCheckRtvScreen(),


  // Return To Vendor
  ReturnVendorScreen.routeName: (context) => ReturnVendorScreen(),



  // Stock Counting
  StockCountingHeader.routeName: (context) => StockCountingHeader(),

};
