import 'package:flutter/material.dart';
import 'package:msi_app/utils/constants.dart';

class ItemHeader extends StatelessWidget {
  final String username;
  final String warehouse;

  const ItemHeader({
    @required this.username,
    @required this.warehouse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username: $username',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          Text(warehouse),
        ],
      ),
    );
  }
}
