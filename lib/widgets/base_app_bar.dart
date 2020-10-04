import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return AppBar(
      title: Text('WMS Mobile'),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            showDialog(
              context: context,
              child: AlertDialog(
                title: Text('Logout'),
                content: Text('Are you sure want to logout?'),
                actions: [
                  buildActionButton(
                    label: 'Cancel',
                    onClick: () => Navigator.of(context).pop(),
                  ),
                  buildActionButton(
                    label: 'OK',
                    onClick: () => authProvider.logout(context),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildActionButton({String label, Function onClick}) {
    return FlatButton(
      child: Text(label),
      onPressed: onClick,
    );
  }
}
