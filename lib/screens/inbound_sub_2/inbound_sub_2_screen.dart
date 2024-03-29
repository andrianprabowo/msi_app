import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/put_away_rfo/put_away_rfo_screen.dart';
import 'package:msi_app/screens/receipt_vendor_rfo/receipt_vendor_rfo_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class InboundSub2Screen extends StatelessWidget {
  static const routeName = '/inbound_sub_2';

  @override
  Widget build(BuildContext context) {
    var hak2 = '';
    var hak4 = '';
    final whsProvider = Provider.of<AuthProvider>(context, listen: false);
    // modul = whsProvider.itemsMenu;
    whsProvider.itemsMenu.forEach((element) {
      if (element.permName == 'Inbound - Receipt Outlet') {
        hak2 = element.authorized;
      }
      if (element.permName == 'Put Away From Outlet') {
        hak4 = element.authorized;
      }
    });

     final List<Map<String, Object>> menus = [
      if (hak2 == 'Y')
    {
      'icon': Icons.shopping_cart,
      'label': 'Receipt Return from Outlet',
      'routeName': ReceiptVendorRfoScreen.routeName,
    },
      if (hak4 == 'Y')
    {
      'icon': Icons.move_to_inbox,
      'label': 'Put Away From Outlet',
      'routeName': PutAwayRfoScreen.routeName,
    },
  ];
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
