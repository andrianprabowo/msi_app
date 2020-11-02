import 'package:flutter/material.dart';
import 'package:msi_app/screens/inventory_dispatch/inventory_dispatch_header_screen.dart';
import 'package:msi_app/screens/picker_pick/picker_pick_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class OutboundSub1Screen extends StatelessWidget {
  static const routeName = '/outbound_sub_1';

  final List<Map<String, Object>> menus = [
    {
      'icon': Icons.event_note,
      'label': 'Picker Pick List',
      'routeName': PickerPickScreen.routeName,
    },
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
