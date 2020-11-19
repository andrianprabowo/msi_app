import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/dashboard_provider.dart';
import 'package:msi_app/screens/dashboard/widgets/item_dashboard.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard_screen';

  Future<void> refreshData(BuildContext context) async {
    final listProv = Provider.of<DashboardProvider>(context, listen: false);
    await listProv.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('Dashboard  ${authProvider.warehouseId}'),
            Divider(),
            buildItemList(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildButtonHome(context)
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context),
            child: Consumer<DashboardProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemDashboard(provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildButtonHome(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Skip to Main Menu'),
        onPressed: () async {
            Navigator.of(context).pop();
        },
      ),
    );
  }
}
