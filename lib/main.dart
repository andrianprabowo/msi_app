import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/bin_rtv_provider.dart';
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
import 'package:msi_app/providers/storage_bin_item_provider.dart';
import 'package:msi_app/providers/storage_bin_item_rfo_provider.dart';
import 'package:msi_app/providers/warehouse_provider.dart';
import 'package:msi_app/utils/routes.dart';
import 'package:msi_app/utils/theme.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (_) => InventoryDispatchItemSoProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispatchBinSoProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispathBatchSoProvider()),

        ChangeNotifierProvider(
            create: (_) => InventoryDispatchHeaderRtvProvider()),
        ChangeNotifierProvider(
            create: (_) => InventoryDispatchDetailRtvProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispatchItemRtvProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispatchBinRtvProvider()),
        ChangeNotifierProvider(create: (_) => InventoryDispathBatchRtvProvider()),
        ChangeNotifierProvider(create: (_) => BinRtvProvider()),
        ChangeNotifierProvider(create: (_) => BinnyaPicListProvider()),

        
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
