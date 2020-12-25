import 'package:flutter/material.dart';
import 'package:msi_app/providers/modul.provider.dart';
import 'package:msi_app/screens/dashboard/dashboard_screen.dart';
import 'package:msi_app/screens/stock_counting_header/stock_counting_header_screen.dart';
import 'package:msi_app/screens/stock_inquiry_header/stock_inquiry_header_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/screens/inbound/inbound_screen.dart';
import 'package:msi_app/screens/outbound/outbound_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  

  Future<void> refreshData(BuildContext context) async {
    final pickItemProvider =
        Provider.of<ModulProvider>(context, listen: false);
    await pickItemProvider.getModulByUsername();
  }

  final List<Map<String, Object>> menus = [
    {
      'icon': Icons.all_inbox,
      'label': 'Inbound Transaction',
      'routeName': InboundScreen.routeName,
    },
    {
      'icon': Icons.outbond,
      'label': 'Outbound Transaction',
      'routeName': OutboundScreen.routeName,
    },
    {
      'icon': Icons.location_city,
      'label': 'Production',
      'routeName': ProductionScreen.routeName,
    },
    {
      'icon': Icons.account_balance_wallet,
      'label': 'Stock Counting',
      'routeName': StockCountingHeaderScreen.routeName,
    },
    {
      'icon': Icons.find_in_page,
      'label': 'Stock Inquiry',
      'routeName': StockInquiryHeaderScreen.routeName,
    },
    {
      'icon': Icons.account_balance,
      'label': 'Dashboard',
      'routeName': DashboardScreen.routeName,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemHeader(),
            Divider(),
            SizedBox(height: getProportionateScreenHeight(40)),
            Expanded(
              child: GridView(
                children: menus
                    .map((menu) => ItemMenu(
                          iconData: menu['icon'],
                          label: menu['label'],
                          routeName: menu['routeName'],
                        ))
                    .toList(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 2,
                  mainAxisSpacing: getProportionateScreenHeight(36),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
