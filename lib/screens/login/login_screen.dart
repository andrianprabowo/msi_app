import 'package:flutter/material.dart';
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/providers/warehouse_provider.dart';
import 'package:msi_app/screens/login/widgets/login_form.dart';
import 'package:provider/provider.dart';
import 'package:msi_app/utils/size_config.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final warehouseProvider = Provider.of<WarehouseProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Image.asset(
                  'assets/images/logo.png',
                  height: getProportionateScreenHeight(100),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                FutureBuilder(
                  future: warehouseProvider.getAllWarehouse(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    List<Warehouse> list = snapshot.data;
                    return LoginForm(list);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
