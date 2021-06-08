import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/inbound_sub_1/inbound_sub_1_screen.dart';
import 'package:msi_app/screens/inbound_sub_2/inbound_sub_2_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class InboundScreen extends StatelessWidget {
  static const routeName = '/inbound';

  @override
  Widget build(BuildContext context) {
    var hak1 = '';
    var hak2 = '';
    var hak3 = '';
    var hak4 = '';
    final whsProvider = Provider.of<AuthProvider>(context, listen: false);
    // modul = whsProvider.itemsMenu;
    whsProvider.itemsMenu.forEach((element) {
      if (element.permName == 'Receipt From Vendor') {
        hak1 = element.authorized;
      }
      if (element.permName == 'Inbound - Receipt Outlet') {
        hak2 = element.authorized;
      }
      if (element.permName == 'Put Away From Vendor') {
        hak3 = element.authorized;
      }
      if (element.permName == 'Put Away From Outlet') {
        hak4 = element.authorized;
      }
    });
    print('hak 1 $hak1');
    print('hak 2 $hak2');
    print('hak 3 $hak3');
    print('hak 4 $hak4');

    final List<Map<String, Object>> menus = [
      if (hak1 == 'Y' || hak3 == 'Y')
        {
          'icon': Icons.receipt_long,
          'label': 'Receipt From Vendor ',
          'routeName': InboundSub1Screen.routeName,
        },
      if (hak2 == 'Y' || hak4 == 'Y')
        {
          'icon': Icons.settings_backup_restore,
          'label': 'Return From Outlet',
          'routeName': InboundSub2Screen.routeName,
        },
      // {
      //   'icon': Icons.undo,
      //   'label': 'Return Form Outlet',
      //   'routeName': ReturnOutletScreen.routeName,
      // },
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
