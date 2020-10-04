import 'package:flutter/material.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/screens/inbound/inbound_screen.dart';
import 'package:msi_app/screens/outbound/outbound_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/screens/stock_counting/stock_counting_screen.dart';
import 'package:msi_app/screens/stock_inquiry/stock_inquiry_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  final List<Map<String, Object>> menus = [
    {
      'icon': Icons.archive,
      'label': 'Inbound Transaction',
      'routeName': InboundScreen.routeName,
    },
    {
      'icon': Icons.unarchive,
      'label': 'Outbound Transaction',
      'routeName': OutboundScreen.routeName,
    },
    {
      'icon': Icons.business,
      'label': 'Production',
      'routeName': ProductionScreen.routeName,
    },
    {
      'icon': Icons.assignment,
      'label': 'Stock Counting',
      'routeName': StockCountingScreen.routeName,
    },
    {
      'icon': Icons.search,
      'label': 'Stock Inquiry',
      'routeName': StockInquiryScreen.routeName,
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
