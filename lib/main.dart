import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/item_po_provider.dart';
import 'package:msi_app/providers/pick_item_receive_provider.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:msi_app/providers/purchase_order_provider.dart';
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
        ChangeNotifierProvider(create: (_) => WarehouseProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseOrderProvider()),
        ChangeNotifierProvider(create: (_) => ItemPoProvider()),
        ChangeNotifierProvider(create: (_) => PickListWhsProvider()),
        ChangeNotifierProvider(create: (_) => PickItemReceiveProvider()),
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
