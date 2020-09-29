import 'package:flutter/material.dart';
import 'package:msi_app/models/staging_bin.dart';
import 'package:msi_app/screens/put_bin/put_bin_screen.dart';
import 'package:msi_app/utils/constants.dart';

class ItemStaging extends StatelessWidget {
  final StagingBin item;

  const ItemStaging(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PutBinScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(item.binCode),
            buildRow(item.warehouse),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
