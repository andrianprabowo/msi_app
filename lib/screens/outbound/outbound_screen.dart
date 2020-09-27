import 'package:flutter/material.dart';
import 'package:msi_app/screens/inventory_dispatch/inventory_dispatch_screen.dart';
import 'package:msi_app/screens/picker_pick/picker_pick_screen.dart';
import 'package:msi_app/screens/return_vendor/return_vendor_screen.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class OutboundScreen extends StatelessWidget {
  static const routeName = '/outbound';

  final String username = 'user@mail.com';
  final String warehouse = 'Warehouse Name';
  final List<Map<String, Object>> menus = [
    {
      'icon': Icons.description,
      'label': 'Picker Pick List',
      'routeName': PickerPickScreen.routeName,
    },
    {
      'icon': Icons.local_shipping,
      'label': 'Inventory Dispatch',
      'routeName': InventoryDispatchScreen.routeName,
    },
    {
      'icon': Icons.redo,
      'label': 'Return To Vendor',
      'routeName': ReturnVendorScreen.routeName,
    },
  ];

  void logout(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('Outbound Transaction')),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemHeader(
              username: username,
              warehouse: warehouse,
            ),
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
