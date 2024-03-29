import 'package:flutter/material.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch/inventory_dispatch_batch_screen.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_rtv/inventory_dispatch_batch_rtv_screen.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_so/inventory_dispatch_batch_so_screen.dart';
import 'package:msi_app/screens/barcode_grpo/barcode_grpo_screen.dart';
import 'package:msi_app/screens/dashboard/dashboard_screen.dart';
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
import 'package:msi_app/screens/list_inv_dispatch/list_inv_dispatch_screen.dart';
import 'package:msi_app/screens/list_inv_dispatch_detail/list_inv_dispatch_detail_screen.dart';
import 'package:msi_app/screens/list_inv_dispatch_rtv/list_inv_dispatch_rtv_screen.dart';
import 'package:msi_app/screens/list_inv_dispatch_rtv_detail/list_inv_dispatch_rtv_detail_screen.dart';
import 'package:msi_app/screens/list_inv_dispatch_so/list_inv_dispatch_so_screen.dart';
import 'package:msi_app/screens/list_inv_dispatch_so_detail/list_inv_dispatch_so_detail_screen.dart';
import 'package:msi_app/screens/list_pick_list/list_pick_list_screen.dart';
import 'package:msi_app/screens/list_pick_list_detail/list_pick_list_detail_screen.dart';
import 'package:msi_app/screens/list_pick_list_rtv/list_pick_list_rtv_screen.dart';
import 'package:msi_app/screens/list_pick_list_rtv_detail/list_pick_list_rtv_detail_screen.dart';
import 'package:msi_app/screens/list_pick_list_so/list_pick_list_so_screen.dart';
import 'package:msi_app/screens/list_pick_list_so_detail/list_pick_list_so_detail_screen.dart';
import 'package:msi_app/screens/list_put_away/list_put_away_screen.dart';
import 'package:msi_app/screens/list_put_away_detail/list_put_away_detail_screen.dart';
import 'package:msi_app/screens/list_put_away_outlet/list_put_away_outlet_screen.dart';
import 'package:msi_app/screens/list_put_away_outlet_detail/list_put_away_detail_screen.dart';
import 'package:msi_app/screens/list_receipt_from_vendor/list_receipt_from_vendor_screen.dart';
import 'package:msi_app/screens/list_receipt_from_vendor_detail/list_receipt_from_vendor_detail_screen.dart';
import 'package:msi_app/screens/list_receipt_from_vendor_outlet/list_receipt_from_vendor_outlet_screen.dart';
import 'package:msi_app/screens/list_receipt_from_vendor_outlet_detail/list_receipt_from_vendor_outlet_detail_screen.dart';
import 'package:msi_app/screens/list_stck_count/list_stck_count_screen.dart';
import 'package:msi_app/screens/list_stck_count_detail/list_stck_count_detail_screen.dart';
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
import 'package:msi_app/screens/prod_list_issue_rm_detail/list_issue_raw_rm_detail_screen.dart';
import 'package:msi_app/screens/prod_list_pick_list_detail/prod_list_pick_list_detail_screen.dart';
import 'package:msi_app/screens/prod_list_pick_list_detail_receipt/prod_list_pick_list_detail_receipt_screen.dart';
import 'package:msi_app/screens/prod_receipt_fg_detail/list_receipt_fg_detail_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/screens/production_issue_item_change/production_issue_item_change_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_bin/production_receipt_rm_bin_screen.dart';
import 'package:msi_app/screens/put_away/put_away_screen.dart';
import 'package:msi_app/screens/put_away_rfo/put_away_rfo_screen.dart';
import 'package:msi_app/screens/receipt_batch_rfo/receipt_batch_rfo_screen.dart';
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
import 'package:msi_app/screens/stock_count_sub_1/stock_count_sub_1_screen.dart';
import 'package:msi_app/screens/stock_counting/stock_counting_screen.dart';
import 'package:msi_app/screens/stock_counting_batch/stock_counting_batch_screen.dart';
import 'package:msi_app/screens/stock_counting_bin/stock_counting_bin_screen.dart';
import 'package:msi_app/screens/stock_counting_bin_exstra/stock_counting_bin_exstra_screen.dart';
import 'package:msi_app/screens/stock_counting_check/stock_counting_check.dart';
import 'package:msi_app/screens/stock_counting_header/stock_counting_header_screen.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/screens/stock_inquiry/stock_inquiry_screen.dart';
import 'package:msi_app/screens/stock_inquiry_batch/stock_inquiry_batch_screen.dart';
import 'package:msi_app/screens/stock_inquiry_detail/stock_inquiry_detail.dart';
import 'package:msi_app/screens/stock_inquiry_header/stock_inquiry_header_screen.dart';
import 'package:msi_app/screens/stock_inquiry_sub_1/stock_inq_sub_1_screen.dart';
import 'package:msi_app/screens/storage_bin_item/storage_bin_item_screen.dart';
import 'package:msi_app/screens/storage_bin_item_rfo/storage_bin_item_rfo_screen.dart';
import 'package:msi_app/screens/transfer_to_production/transfer_to_production_screen.dart';
import 'package:msi_app/screens/production_pick_list/production_pick_list_screen.dart';
import 'package:msi_app/screens/production_pick_list_bin/production_pick_list_bin_screen.dart';
import 'package:msi_app/screens/production_pick_list_item/production_pick_list_item_screen.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/production_pick_list_item_batch_screen.dart';
import 'package:msi_app/screens/production_pick_list_final_check/production_pick_list_final_check_screen.dart';
import 'package:msi_app/screens/production_pick_list_all_transaction/production_pick_list_all_transaction_screen.dart';
import 'package:msi_app/screens/production_issue/production_issue_screen.dart';
import 'package:msi_app/screens/production_issue_number/production_issue_number_screen.dart';
import 'package:msi_app/screens/production_issue_item/production_issue_item_screen.dart';
import 'package:msi_app/screens/production_issue_item_batch/production_issue_item_batch_screen.dart';
import 'package:msi_app/screens/production_issue_final_check/production_issue_final_check_screen.dart';
import 'package:msi_app/screens/production_issue_all_transaction/production_issue_all_transaction_screen.dart';
import 'package:msi_app/screens/production_receipt/production_receipt_screen.dart';
import 'package:msi_app/screens/production_receipt_item/production_receipt_item_screen.dart';
import 'package:msi_app/screens/production_receipt_final_check/production_receipt_final_check_screen.dart';
import 'package:msi_app/screens/production_receipt_all_transaction/production_receipt_all_transaction_screen.dart';
import 'package:msi_app/screens/production_receipt_rm/production_receipt_rm_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_number/production_receipt_rm_number_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_item/production_receipt_rm_item_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_item_batch/production_receipt_rm_item_batch_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_final_check/production_receipt_rm_final_check_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_all_transaction/production_receipt_rm_all_transaction_screen.dart';

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

  // Return From Outlet
  ReturnOutletScreen.routeName: (context) => ReturnOutletScreen(),

  // OUTBOUND TRANSCATION

  // Picker Pick List
  PickerPickScreen.routeName: (context) => PickerPickScreen(),
  PickItemReceiveScreen.routeName: (context) => PickItemReceiveScreen(),
  PickListBinScreen.routeName: (context) => PickListBinScreen(),
  PickItemBatchScreen.routeName: (context) => PickItemBatchScreen(),
  PickCheckScreen.routeName: (context) => PickCheckScreen(),

  //test

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
  ReceiptBatchRfoScreen.routeName: (context) => ReceiptBatchRfoScreen(),

  // Stock Counting
  StockCountingHeaderScreen.routeName: (context) => StockCountingHeaderScreen(),
  StockCountingBinScreen.routeName: (context) => StockCountingBinScreen(),
  StockCountingItemScreen.routeName: (context) => StockCountingItemScreen(),
  StockCountingBatchScreen.routeName: (context) => StockCountingBatchScreen(),
  StockCountingCheckScreen.routeName: (context) => StockCountingCheckScreen(),
  StockCountingBinExstraScreen.routeName: (context) =>
      StockCountingBinExstraScreen(),

// Stock Inquiry
  StockInquiryHeaderScreen.routeName: (context) => StockInquiryHeaderScreen(),
  StockInquiryDetailScreen.routeName: (context) => StockInquiryDetailScreen(),
  StockInquiryBatchScreen.routeName: (context) => StockInquiryBatchScreen(),

// List
  ListReceiptFromVendorScreen.routeName: (context) =>
      ListReceiptFromVendorScreen(),
  ListReceiptFromVendorOutletScreen.routeName: (context) =>
      ListReceiptFromVendorOutletScreen(),
  ListInvDispatchScreen.routeName: (context) => ListInvDispatchScreen(),
  ListInvDispatchSoScreen.routeName: (context) => ListInvDispatchSoScreen(),
  ListInvDispatchRtvScreen.routeName: (context) => ListInvDispatchRtvScreen(),

  ListPutAwayScreen.routeName: (context) => ListPutAwayScreen(),
  ListPutAwayOutletScreen.routeName: (context) => ListPutAwayOutletScreen(),

  ListPickListScreen.routeName: (context) => ListPickListScreen(),
  ListPickListSoScreen.routeName: (context) => ListPickListSoScreen(),
  ListPickListRtvScreen.routeName: (context) => ListPickListRtvScreen(),

  ListStckCountScreen.routeName: (context) => ListStckCountScreen(),

  BarcodeGrpoScreen.routeName: (context) => BarcodeGrpoScreen(),
  DashboardScreen.routeName: (context) => DashboardScreen(),

//PRODUCTION
  TransferToProductionScreen.routeName: (context) =>
      TransferToProductionScreen(),

  //Pick List - Raw Mat
  ProductionPickList.routeName: (context) => ProductionPickList(),
  ProductionPickListBin.routeName: (context) => ProductionPickListBin(),
  ProductionPickListItem.routeName: (context) => ProductionPickListItem(),
  ProductionPickListItemBatch.routeName: (context) =>
      ProductionPickListItemBatch(),
  ProductionPickListFinalCheck.routeName: (context) =>
      ProductionPickListFinalCheck(),
  ProductionPickListAllTransaction.routeName: (context) =>
      ProductionPickListAllTransaction(),

  //Issue - Raw Mat
  ProductionIssue.routeName: (context) => ProductionIssue(),
  ProductionIssueNumber.routeName: (context) => ProductionIssueNumber(),
  ProductionIssueItem.routeName: (context) => ProductionIssueItem(),
  ProductionIssueItemChange.routeName: (context) => ProductionIssueItemChange(),
  ProductionIssueItemBatch.routeName: (context) => ProductionIssueItemBatch(),
  ProductionIssueFinalCheck.routeName: (context) => ProductionIssueFinalCheck(),
  ProductionIssueAllTransaction.routeName: (context) =>
      ProductionIssueAllTransaction(),

  //Receipt Finish Good
  ProductionReceipt.routeName: (context) => ProductionReceipt(),
  ProductionReceiptItem.routeName: (context) => ProductionReceiptItem(),
  ProductionReceiptFinalCheck.routeName: (context) =>
      ProductionReceiptFinalCheck(),
  ProductionReceiptAllTransaction.routeName: (context) =>
      ProductionReceiptAllTransaction(),

  //Receipt - Raw Material
  ProductionReceiptRM.routeName: (context) => ProductionReceiptRM(),
  ProductionReceiptRMNumber.routeName: (context) => ProductionReceiptRMNumber(),
  ProductionReceiptRMItem.routeName: (context) => ProductionReceiptRMItem(),
  ProductionReceiptRMItemBatch.routeName: (context) =>
      ProductionReceiptRMItemBatch(),
  ProductionReceiptRMFinalCheck.routeName: (context) =>
      ProductionReceiptRMFinalCheck(),
  ProductionReceiptRMAllTransaction.routeName: (context) =>
      ProductionReceiptRMAllTransaction(),
  ProductionReceiptRmBinScreen.routeName: (context) =>
      ProductionReceiptRmBinScreen(),

  //Detail List
  ListReceiptFromVendorDetailScreen.routeName: (context) =>
      ListReceiptFromVendorDetailScreen(),
  ListPutAwayDetailScreen.routeName: (context) => ListPutAwayDetailScreen(),
  ListReceiptFromVendorOutletDetailScreen.routeName: (context) => ListReceiptFromVendorOutletDetailScreen(),
  ListPutAwayOutletDetailScreen.routeName: (context) => ListPutAwayOutletDetailScreen(),
  ListPickListDetailScreen.routeName: (context) => ListPickListDetailScreen(),
  ListPickListRtvDetailScreen.routeName: (context) => ListPickListRtvDetailScreen(),
  ListPickListSoDetailScreen.routeName: (context) => ListPickListSoDetailScreen(),
  ListInvDispatchSoDetailScreen.routeName: (context) => ListInvDispatchSoDetailScreen(),
  ListInvDispatchRtvDetailScreen.routeName: (context) => ListInvDispatchRtvDetailScreen(),
  ListInvDispatchDetailScreen.routeName: (context) => ListInvDispatchDetailScreen(),
  ProdListPickListDetailScreen.routeName: (context) => ProdListPickListDetailScreen(),
  ProdListPickListDetailReceiptScreen.routeName: (context) => ProdListPickListDetailReceiptScreen(),
  ListIssueRawRmDetailScreen.routeName: (context) => ListIssueRawRmDetailScreen(),
  ListReceiptFgDetailScreen.routeName: (context) => ListReceiptFgDetailScreen(),
  ListStckCountDetailScreen.routeName: (context) => ListStckCountDetailScreen(),
  StockCountSub1Screen.routeName: (context) => StockCountSub1Screen(),
  StockInquirySub1Screen.routeName: (context) => StockInquirySub1Screen(),

};
