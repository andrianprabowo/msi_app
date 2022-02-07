import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/modul.provider.dart';
import 'package:msi_app/screens/dashboard/dashboard_screen.dart';
import 'package:msi_app/screens/stock_counting_header/stock_counting_header_screen.dart';
import 'package:msi_app/screens/stock_inquiry_header/stock_inquiry_header_screen.dart';
import 'package:msi_app/widgets/base_app_bar.dart';
import 'package:msi_app/widgets/item_header.dart';
import 'package:msi_app/widgets/item_menu.dart';
import 'package:msi_app/screens/inbound/inbound_screen.dart';
import 'package:msi_app/screens/outbound/outbound_screen.dart';
import 'package:msi_app/screens/production/production_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  Future<void> refreshData(BuildContext context) async {
    final pickItemProvider = Provider.of<ModulProvider>(context, listen: false);
    await pickItemProvider.getModulByUsername();
  }

  @override
  Widget build(BuildContext context) {
    var hak1 = '';
    var hak2 = '';
    var hak3 = '';
    var hak4 = '';
    var hak5 = '';
    var hak6 = '';
    var hak7 = '';
    var hak8 = '';
    var hak9 = '';
    var hak10 = '';
    var hak11 = '';
    var hak12 = '';
    var hak13 = '';
    var hak14 = '';
    var hak15 = '';
    var hak16 = '';
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
      if (element.permName == 'Stock Counting') {
        hak15 = element.authorized;
      }
      if (element.permName == 'Stock Inquiry') {
        hak16 = element.authorized;
      }
    });
print('hak 1 $hak1');
    print('hak 2 $hak2');
    print('hak 3 $hak3');
    print('hak 4 $hak4');
    final List<Map<String, Object>> menus = [
      if (hak1 == 'Y' || hak2 == 'Y' || hak3 == 'Y' || hak4 == 'Y')
        {
          'icon': Icons.all_inbox,
          'label': 'Inbound Transaction',
          'routeName': InboundScreen.routeName,
        },
      if (hak5 == 'Y' || hak6 == 'Y' || hak7 == 'Y' || hak8 == 'Y'|| hak9 == 'Y'|| hak10 == 'Y')

      {
        'icon': Icons.outbond,
        'label': 'Outbound Transaction',
        'routeName': OutboundScreen.routeName,
      },
      if (hak11 == 'Y' || hak12 == 'Y' || hak13 == 'Y' || hak14 == 'Y')
      {
        'icon': Icons.location_city,
        'label': 'Production',
        'routeName': ProductionScreen.routeName,
      },
      if (hak15 == 'Y')
      {
        'icon': Icons.account_balance_wallet,
        'label': 'Stock Counting',
        'routeName': StockCountingHeaderScreen.routeName,
      },
      if (hak16 == 'Y' )
      {
        'icon': Icons.find_in_page,
        'label': 'Stock Inquiry',
        'routeName': StockInquiryHeaderScreen.routeName,
      },
      {
        'icon': Icons.account_balance,
        'label': 'Dashboard',
        'routeName': DashboardScreen.routeName,
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
            )
          ],
        ),
      ),
    );
  }
}
