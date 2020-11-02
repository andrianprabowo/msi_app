import 'package:flutter/material.dart';
import 'package:msi_app/screens/outbound_sub_1/outbound_sub_1_screen.dart';
import 'package:msi_app/screens/outbound_sub_2/outbound_sub_2_screen.dart';
import 'package:msi_app/screens/outbound_sub_3/outbound_sub_3_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class OutboundScreen extends StatelessWidget {
  static const routeName = '/outbound';

  final List<Map<String, Object>> menus = [
    {
      'icon': Icons.local_shipping,
      'label': 'Transfer to Outlet',
      'routeName': OutboundSub1Screen.routeName,
    },
    {
      'icon': Icons.point_of_sale,
      'label': 'Sales Order',
      'routeName': OutboundSub2Screen.routeName,
    },
    {
      'icon': Icons.settings_backup_restore,
      'label': 'Return to Vendor',
      'routeName': OutboundSub3Screen.routeName,
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
