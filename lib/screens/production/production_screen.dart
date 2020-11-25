import 'package:flutter/material.dart';
import 'package:msi_app/screens/production_issue/production_issue_screen.dart';
import 'package:msi_app/screens/production_receipt/production_receipt_screen.dart';
import 'package:msi_app/screens/transfer_to_production/transfer_to_production_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';

class ProductionScreen extends StatelessWidget {
  static const routeName = '/production';

  final List<Map<String, Object>> menus = [
    {
      'icon':Icons.emoji_transportation,
      'label':'Transfer to Production',
      'routeName':TransferToProductionScreen.routeName,
    },
    {
      'icon': Icons.ac_unit,
      'label': 'Issue (Raw Material)',
      'routeName':ProductionIssue.routeName,
    },
    {
      'icon':Icons.check,
      'label':'Receipt Finish Goods',
      'routeName':ProductionReceipt.routeName,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Production')),
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