import 'package:flutter/material.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  void logout(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final String username = 'user@mail.com';
    final String warehouseName = 'The Harvest Pantai Indah Kapuk';
    final List<Map<String, Object>> menus = [
      {
        'icon': Icons.archive,
        'label': 'Inbound Transaction',
        'routeName': '',
      },
      {
        'icon': Icons.unarchive,
        'label': 'Outbound Transaction',
        'routeName': '',
      },
      {
        'icon': Icons.business,
        'label': 'Production',
        'routeName': '',
      },
      {
        'icon': Icons.assignment,
        'label': 'Stock Counting',
        'routeName': '',
      },
      {
        'icon': Icons.search,
        'label': 'Stock Inquiry',
        'routeName': '',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('WMS Mobile'),
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
          children: [
            buildHeader(username, warehouseName),
            Divider(),
            SizedBox(height: getProportionateScreenHeight(40)),
            Expanded(
              child: GridView(
                children: menus.map((menu) => buildItemMenu(menu)).toList(),
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

  Widget buildItemMenu(Map<String, Object> menu) {
    return InkWell(
      onTap: () => {},
      child: Container(
        child: Column(
          children: [
            Icon(
              menu['icon'],
              size: 50,
              color: Colors.black87,
            ),
            SizedBox(height: getProportionateScreenHeight(kSmall)),
            Text(
              menu['label'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(String username, String warehouseName) {
    return Padding(
      padding: const EdgeInsets.all(kSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username: $username',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          Text(warehouseName),
        ],
      ),
    );
  }
}
