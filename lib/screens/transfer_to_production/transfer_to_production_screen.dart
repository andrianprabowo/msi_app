import 'package:flutter/material.dart';
import 'package:msi_app/screens/production_pick_list/production_pick_list_screen.dart';
import 'package:msi_app/screens/production_receipt_rm/production_receipt_rm_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';

class TransferToProductionScreen extends StatelessWidget {
  static const routeName = '/transfer_to_production';

  final List<Map<String, Object>> menus = [
    {
      'icon': Icons.event_note,
      'label': 'Pick List (Raw Material)',
      'routeName': ProductionPickList.routeName,
    },
    {
      'icon':Icons.moped,
      'label':'Receipt (Raw Material)',
      'routeName':ProductionReceiptRM.routeName,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer to Production'),
      ),
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