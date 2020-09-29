import 'package:flutter/material.dart';
import 'package:msi_app/providers/warehouse_provider.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  void getDataWarehouse(BuildContext context) async {
    final warehouseProvider =
        Provider.of<WarehouseProvider>(context, listen: false);
    await warehouseProvider.getAllWarehouse();

    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    getDataWarehouse(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kMedium),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: getProportionateScreenHeight(150),
                  ),
                ),
              ),
              Text('WMS Mobile App'),
              Text('Version 1.0'),
            ],
          ),
        ),
      ),
    );
  }
}
