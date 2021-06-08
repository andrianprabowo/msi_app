import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/outbound_sub_1/outbound_sub_1_screen.dart';
import 'package:msi_app/screens/outbound_sub_2/outbound_sub_2_screen.dart';
import 'package:msi_app/screens/outbound_sub_3/outbound_sub_3_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class OutboundScreen extends StatelessWidget {
  static const routeName = '/outbound';

  @override
  Widget build(BuildContext context) {
    var hak5 = '';
    var hak6 = '';
    var hak7 = '';
    var hak8 = '';
    var hak9 = '';
    var hak10 = '';
    final whsProvider = Provider.of<AuthProvider>(context, listen: false);
    // modul = whsProvider.itemsMenu;
    whsProvider.itemsMenu.forEach((element) {
      if (element.permName == 'Picker Pick List') {
        hak5 = element.authorized;
      }
      if (element.permName == 'Picker Pick List Sales Order') {
        hak6 = element.authorized;
      }
      if (element.permName == 'Picker Pick List To Vendor') {
        hak7 = element.authorized;
      }
      if (element.permName == 'Inventory Dispatch') {
        hak8 = element.authorized;
      }
      if (element.permName == 'Inventory Dispatch SO') {
        hak9 = element.authorized;
      }
      if (element.permName == 'Inventory Dispatch To Vendor') {
        hak10 = element.authorized;
      }
    });

    final List<Map<String, Object>> menus = [
      if (hak5 == 'Y' || hak8 == 'Y')
        {
          'icon': Icons.local_shipping,
          'label': 'Transfer to Outlet',
          'routeName': OutboundSub1Screen.routeName,
        },
      if (hak6 == 'Y' || hak9 == 'Y')
        {
          'icon': Icons.point_of_sale,
          'label': 'Sales Order',
          'routeName': OutboundSub2Screen.routeName,
        },
      if (hak7 == 'Y' || hak10 == 'Y')
        {
          'icon': Icons.settings_backup_restore,
          'label': 'Return to Vendor',
          'routeName': OutboundSub3Screen.routeName,
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
