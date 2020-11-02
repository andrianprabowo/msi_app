import 'package:flutter/material.dart';
import 'package:msi_app/screens/put_away/put_away_screen.dart';
import 'package:msi_app/screens/receipt_vendor/receipt_vendor_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class InboundSub1Screen extends StatelessWidget {
  static const routeName = '/inbound_sub_1';

  final List<Map<String, Object>> menus = [
    {
      'icon': Icons.shopping_cart,
      'label': 'Receipt From Vendor',
      'routeName': ReceiptVendorScreen.routeName,
    },
    {
      'icon': Icons.move_to_inbox,
      'label': 'Put Away From Vendor',
      'routeName': PutAwayScreen.routeName,
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
            ),
          ],
        ),
      ),
    );
  }
}
