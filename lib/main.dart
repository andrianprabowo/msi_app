import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msi_app/utils/router.dart';
import 'package:msi_app/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
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
