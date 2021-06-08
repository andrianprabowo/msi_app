import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_issue/production_issue_screen.dart';
import 'package:msi_app/screens/production_receipt/production_receipt_screen.dart';
import 'package:msi_app/screens/transfer_to_production/transfer_to_production_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:provider/provider.dart';

class ProductionScreen extends StatelessWidget {
  static const routeName = '/production';

  @override
  Widget build(BuildContext context) {
    var hak11 = '';
    var hak12 = '';
    var hak13 = '';
    var hak14 = '';
    final whsProvider = Provider.of<AuthProvider>(context, listen: false);
    // modul = whsProvider.itemsMenu;
    whsProvider.itemsMenu.forEach((element) {
      if (element.permName == 'Issue (Raw Material)') {
        hak11 = element.authorized;
      }
      if (element.permName == 'Pick List (Raw Material)') {
        hak12 = element.authorized;
      }
      if (element.permName == 'Receipt (Raw Material)') {
        hak13 = element.authorized;
      }
      if (element.permName == 'Receipt Finish Goods') {
        hak14 = element.authorized;
      }
    });
    final List<Map<String, Object>> menus = [
      if (hak12 == 'Y' || hak13 == 'Y' )
        {
          'icon': Icons.emoji_transportation,
          'label': 'Transfer to Inter Sentul',
          'routeName': TransferToProductionScreen.routeName,
        },
      if (hak11 == 'Y')
        {
          'icon': Icons.ac_unit,
          'label': 'Issue (Raw Material)',
          'routeName': ProductionIssue.routeName,
        },
      if (hak14 == 'Y')
        {
          'icon': Icons.check,
          'label': 'Receipt Finish Goods',
          'routeName': ProductionReceipt.routeName,
        },
    ];
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
