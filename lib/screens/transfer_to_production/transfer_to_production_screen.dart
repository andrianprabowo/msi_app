import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_pick_list/production_pick_list_screen.dart';
import 'package:msi_app/screens/production_receipt_rm/production_receipt_rm_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:provider/provider.dart';

class TransferToProductionScreen extends StatelessWidget {
  static const routeName = '/transfer_to_production';

  
  @override
  Widget build(BuildContext context) {
    var hak12 = '';
    var hak13 = '';
    final whsProvider = Provider.of<AuthProvider>(context, listen: false);
    // modul = whsProvider.itemsMenu;
    whsProvider.itemsMenu.forEach((element) {
      
      if (element.permName == 'Pick List (Raw Material)') {
        hak12 = element.authorized;
      }
      if (element.permName == 'Receipt (Raw Material)') {
        hak13 = element.authorized;
      }
    
    });
    final List<Map<String, Object>> menus = [
      if (hak12 == 'Y')
    {
      'icon': Icons.event_note,
      'label': 'Pick List',
      'routeName': ProductionPickList.routeName,
    },
      if (hak13 == 'Y')
    {
      'icon':Icons.moped,
      'label':'Receipt',
      'routeName':ProductionReceiptRM.routeName,
    }
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Inter Sentul'),
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