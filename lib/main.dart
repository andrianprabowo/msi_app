import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
