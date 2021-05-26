import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msi_app/providers/auth_provider.dart';
// import 'package:msi_app/providers/batch_number_provider.dart';
import 'package:msi_app/providers/barcode_grpo_provider.dart';
import 'package:msi_app/providers/bin_rtv_provider.dart';
// import 'package:msi_app/providers/bin_rtvo_provider.dart';
import 'package:msi_app/providers/dashboard_provider.dart';
import 'package:msi_app/providers/item_batch_si_provider.dart';
import 'package:msi_app/providers/item_bin_si_provider.dart';
import 'package:msi_app/providers/item_gl_provider.dart';
import 'package:msi_app/providers/list_grpo_detail_provider.dart';
import 'package:msi_app/providers/list_grpo_outlet_detail_provider.dart';
import 'package:msi_app/providers/list_grpo_outlet_provider.dart';
import 'package:msi_app/providers/list_grpo_provider.dart';
import 'package:msi_app/providers/list_inv_dispatch_detail_provider.dart';
import 'package:msi_app/providers/list_inv_dispatch_provider.dart';
import 'package:msi_app/providers/list_inv_dispatch_rtv_detail_provider.dart';
import 'package:msi_app/providers/list_inv_dispatch_rtv_provider.dart';
import 'package:msi_app/providers/list_inv_dispatch_so_detail_provider.dart';
import 'package:msi_app/providers/list_inv_dispatch_so_provider.dart';
import 'package:msi_app/providers/list_pick_list_detail_provider.dart';
import 'package:msi_app/providers/list_pick_list_prod_detail_provider.dart';
import 'package:msi_app/providers/list_pick_list_prod_receipt_detail_provider.dart';
import 'package:msi_app/providers/list_pick_list_provider.dart';
import 'package:msi_app/providers/list_pick_list_rtv_detail_provider.dart';
import 'package:msi_app/providers/list_pick_list_rtv_provider.dart';
import 'package:msi_app/providers/list_pick_list_so_detail_provider.dart';
import 'package:msi_app/providers/list_pick_list_so_provider.dart';
import 'package:msi_app/providers/list_prod_issue_rm_detail_provider.dart';
import 'package:msi_app/providers/list_prod_receipt_fg_detail_provider.dart';
import 'package:msi_app/providers/list_put_away_detail_provider.dart';
import 'package:msi_app/providers/list_put_away_provider.dart';
import 'package:msi_app/providers/list_put_away_rfo_detail_provider.dart';
import 'package:msi_app/providers/list_put_away_rfo_provider.dart';
import 'package:msi_app/providers/list_stck_count_detail_provider.dart';
import 'package:msi_app/providers/list_stck_count_provider.dart';
import 'package:msi_app/providers/modul.provider.dart';
import 'package:msi_app/providers/production_receipt_rm_bin.dart';
import 'package:msi_app/providers/receipt_batch_rfo_provider.dart';
import 'package:msi_app/providers/staging_bin_si.provider.dart';
import 'package:msi_app/providers/stock_counting_batch_provider.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/providers/binnya_pick_list_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_batch_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_batch_rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_batch_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_bin_Rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_bin_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_bin_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_Rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_so_provider.dart';
import 'package:msi_app/providers/item_batch_provider.dart';
import 'package:msi_app/providers/item_batch_rfo_provider.dart';
import 'package:msi_app/providers/item_bin_provider.dart';
import 'package:msi_app/providers/item_bin_rfo_provider.dart';
import 'package:msi_app/providers/item_po_provider.dart';
import 'package:msi_app/providers/item_po_provider_rfo.dart';
import 'package:msi_app/providers/pick_batch_provider.dart';
import 'package:msi_app/providers/pick_batch_rtv_provider.dart';
import 'package:msi_app/providers/pick_batch_so_provider.dart';
import 'package:msi_app/providers/pick_item_receive_provider.dart';
import 'package:msi_app/providers/pick_item_receive_rtv_provider.dart';
import 'package:msi_app/providers/pick_item_receive_so_provider.dart';
import 'package:msi_app/providers/pick_list_bin_provider.dart';
import 'package:msi_app/providers/pick_list_bin_rtv_provider.dart';
import 'package:msi_app/providers/pick_list_bin_so_provider.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:msi_app/providers/pick_list_whs_rtv_provider.dart';
import 'package:msi_app/providers/pick_list_whs_so_provider.dart';
import 'package:msi_app/providers/purchase_order_provider.dart';
import 'package:msi_app/providers/purchase_order_rfo_provider.dart';
import 'package:msi_app/providers/staging_bin.provider.dart';
import 'package:msi_app/providers/staging_bin_rfo.provider.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/providers/bin_production_receipt_provider.dart';
import 'package:msi_app/providers/bin_production_picklist_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/providers/storage_bin_item_provider.dart';
import 'package:msi_app/providers/storage_bin_item_rfo_provider.dart';
import 'package:msi_app/providers/warehouse_provider.dart';
import 'package:msi_app/utils/routes.dart';
import 'package:msi_app/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:msi_app/providers/production_pick_list_provider.dart';
import 'package:msi_app/providers/production_pick_list_bin_provider.dart';
import 'package:msi_app/providers/production_pick_list_item_provider.dart';
import 'package:msi_app/providers/production_pick_list_item_batch_provider.dart';
import 'package:msi_app/providers/production_pick_list_all_transaction_provider.dart';
import 'package:msi_app/providers/production_issue_provider.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/providers/production_issue_item_batch_provider.dart';
import 'package:msi_app/providers/production_issue_all_transaction_provider.dart';
import 'package:msi_app/providers/production_receipt_provider.dart';
import 'package:msi_app/providers/production_receipt_item_provider.dart';
import 'package:msi_app/providers/production_receipt_all_transaction_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_number_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_batch_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_all_transaction_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WarehouseProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseOrderProvider()),
        ChangeNotifierProvider(create: (_) => ItemPoProvider()),
        ChangeNotifierProvider(create: (_) => PickListWhsProvider()),
        ChangeNotifierProvider(create: (_) => PickItemReceiveProvider()),
        ChangeNotifierProvider(create: (_) => PickListBinProvider()),
        ChangeNotifierProvider(create: (_) => PickBatchProvider()),
        ChangeNotifierProvider(create: (_) => PickListWhsSoProvider()),
        ChangeNotifierProvider(create: (_) => PickItemReceiveSoProvider()),
        ChangeNotifierProvider(create: (_) => PickListBinSoProvider()),
        ChangeNotifierProvider(create: (_) => PickBatchSoProvider()),
        ChangeNotifierProvider(create: (_) => PickListWhsRtvProvider()),
        ChangeNotifierProvider(create: (_) => PickItemReceiveRtvProvider()),
        ChangeNotifierProvider(create: (_) => PickListBinRtvProvider()),
        ChangeNotifierProvider(create: (_) => PickBatchRtvProvider()),
        ChangeNotifierProvider(create: (_) => StagingBinProvider()),
        ChangeNotifierProvider(create: (_) => ItemBinProvider()),
        ChangeNotifierProvider(create: (_) => ItemBatchProvider()),
        ChangeNotifierProvider(create: (_) => StorageBinItemProvider()),
        ChangeNotifierProvider(create: (_) => StorageBinItemRfoProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchHeaderProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchDetailProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispatchItemProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseOrderRfoProvider()),
        ChangeNotifierProvider(create: (_) => ItemPoRfoProvider()),
        ChangeNotifierProvider(create: (_) => ItemBinRfoProvider()),
        ChangeNotifierProvider(create: (_) => StagingBinRfoProvider()),
        ChangeNotifierProvider(create: (_) => ItemBatchRfoProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispatchBinProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispathBatchProvider()),

        ChangeNotifierProvider(
            create: (_) => InventoryDispatchHeaderSoProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchDetailSoProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchItemSoProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispatchBinSoProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispathBatchSoProvider()),

        ChangeNotifierProvider(
            create: (_) => InventoryDispatchHeaderRtvProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchDetailRtvProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchItemRtvProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchBinRtvProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispathBatchRtvProvider()),
        ChangeNotifierProvider(create: (_) => BinRtvProvider()),
        // ChangeNotifierProvider(create: (_) => BinRtvoProvider()),
        ChangeNotifierProvider(create: (_) => BinnyaPicListProvider()),

        ChangeNotifierProvider(create: (_) => StockCountingHeaderProvider()),
        ChangeNotifierProvider(create: (_) => StockCountingItemProvider()),
        ChangeNotifierProvider(create: (_) => StockCountingBinProvider()),
        ChangeNotifierProvider(create: (_) => StockCountingBatchProvider()),

        ChangeNotifierProvider(create: (_) => StagingBinSiProvider()),
        ChangeNotifierProvider(create: (_) => ItemBinSiProvider()),
        ChangeNotifierProvider(create: (_) => ItemBatchSiProvider()),

        ChangeNotifierProvider(create: (_) => ListGrpoProvider()),
        ChangeNotifierProvider(create: (_) => ListGrpoOutletProvider()),

        ChangeNotifierProvider(create: (_) => ListPutAwayProvider()),
        ChangeNotifierProvider(create: (_) => ListPutAwayRfoProvider()),

        ChangeNotifierProvider(create: (_) => ListInvDispatchProvider()),
        ChangeNotifierProvider(create: (_) => ListInvDispatchRtvProvider()),
        ChangeNotifierProvider(create: (_) => ListInvDispatchSoProvider()),

        ChangeNotifierProvider(create: (_) => ListPickListProvider()),
        ChangeNotifierProvider(create: (_) => ListPickListRtvProvider()),
        ChangeNotifierProvider(create: (_) => ListPickListSoProvider()),

        ChangeNotifierProvider(create: (_) => ListStckCountProvider()),

        ChangeNotifierProvider(create: (_) => BarcodeGrpoProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),

        ChangeNotifierProvider(create: (_) => ReceiptBatchRfoProvider()),

        //production
        ChangeNotifierProvider(create: (_) => BinProductionReceiptProvider()),
        ChangeNotifierProvider(create: (_) => BinProductionPickListProvider()),
        ChangeNotifierProvider(create: (_) => ProductionPickListProvider()),
        ChangeNotifierProvider(create: (_) => ProductionPickListBinProvider()),
        ChangeNotifierProvider(create: (_) => ProductionPickListItemProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionPickListItemBatchProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionPickListAllTransactionProvider()),
        ChangeNotifierProvider(create: (_) => ProductionIssueProvider()),
        ChangeNotifierProvider(create: (_) => ProductionIssueNumberProvider()),
        ChangeNotifierProvider(create: (_) => ProductionIssueItemProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionIssueItemBatchProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionIssueAllTransactionProvider()),
        ChangeNotifierProvider(create: (_) => ProductionReceiptProvider()),
        ChangeNotifierProvider(create: (_) => ProductionReceiptItemProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionReceiptAllTransactionProvider()),
        ChangeNotifierProvider(create: (_) => ProductionReceiptRMProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionReceiptRMItemListProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionReceiptRMNumberListProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionReceiptRMItemListBatchListProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductionReceiptRMAllTransactionProvider()),
        ChangeNotifierProvider(create: (_) => ProductionReceiptRMBinProvider()),
        ChangeNotifierProvider(create: (_) => ModulProvider()),
        ChangeNotifierProvider(create: (_) => ItemGlProvider()),
        // ChangeNotifierProvider(create: (_) => BatchNumberProvider()),

        ChangeNotifierProvider(create: (_) => ListGrpoDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListPutAwayDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListGrpoOutletDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListPutAwayRfoDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListPickListDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListPickListRtvDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListPickListSooDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListInvDispatchSoDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListInvDispatchRtvDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListInvDispatchDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListPickListProdDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListPickListProdReceiptDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListProdIssueRmDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListProdReceiptFgDetailProvider()),
        ChangeNotifierProvider(create: (_) => ListStckCountDetailProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MSI App',
      theme: themeData(),
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
