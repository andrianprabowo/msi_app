import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:provider/provider.dart';

class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return FutureBuilder(
      future: authProvider.initPrefs(),
      builder: (_, snapshot) {
        return Container(
          padding: const EdgeInsets.all(kSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username: ${authProvider.username}',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              Text(
                '${authProvider.warehouseId} - ${authProvider.warehouseName}',
              ),
            ],
          ),
        );
      },
    );
  }
}
