import 'package:flutter/material.dart';
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/warehouse_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return FutureBuilder(
      future: authProvider.getData(),
      builder: (_, snapshot) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username: ${authProvider.username}',
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  authProvider.warehouseId == null ||
                          authProvider.warehouseId.isEmpty
                      ? Text('No selected Warehouse')
                      : Text(
                          '${authProvider.warehouseId} - ${authProvider.warehouseName}',
                        ),
                ],
              ),
            ),
            buildChangeWarehouse(context),
          ],
        );
      },
    );
  }

  Widget buildChangeWarehouse(BuildContext context) {
    final whsProvider = Provider.of<WarehouseProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return FutureBuilder(
      future: whsProvider.getWarehouseByUsername(),
      builder: (_, snapshot) {
        return IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            SelectDialog.showModal<Warehouse>(
              context,
              label: "Select Warehouse",
              showSearchBox: true,
              items: whsProvider.items,
              itemBuilder: (context, item, _) {
                return ListTile(
                  title: Text(item.whsName),
                  subtitle: Text('ID: ${item.whsCode}'),
                );
              },
              searchBoxDecoration: InputDecoration(hintText: 'Search by name'),
              onChange: (Warehouse selected) {
                authProvider.selectWarehouse(selected);
              },
            );
          },
        );
      },
    );
  }
}
