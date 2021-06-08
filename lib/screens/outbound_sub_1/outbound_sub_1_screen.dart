import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/inventory_dispatch/inventory_dispatch_header_screen.dart';
import 'package:msi_app/screens/picker_pick/picker_pick_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class OutboundSub1Screen extends StatelessWidget {
  static const routeName = '/outbound_sub_1';

  
  @override
  Widget build(BuildContext context) {
    var hak1 = '';
    var hak2 = '';
    final whsProvider = Provider.of<AuthProvider>(context, listen: false);
    // modul = whsProvider.itemsMenu;
    whsProvider.itemsMenu.forEach((element) {
      if (element.permName == 'Picker Pick List') {
        hak1 = element.authorized;
      }
      if (element.permName == 'Inventory Dispatch') {
        hak2 = element.authorized;
      }
    });

    final List<Map<String, Object>> menus = [
      if (hak1 == 'Y')
    {
      'icon': Icons.event_note,
      'label': 'Picker Pick List',
      'routeName': PickerPickScreen.routeName,
    },
      if (hak2 == 'Y')
    {
      'icon': Icons.moped,
      'label': 'Inventory Dispatch',
      'routeName': InventoryDispatchHeaderScreen.routeName,
    },
    // {
    //   'icon': Icons.redo,
    //   'label': 'Return To Vendor',
    //   'routeName': ReturnVendorScreen.routeName,
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
