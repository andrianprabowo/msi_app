import 'package:flutter/material.dart';
import 'package:msi_app/models/staging_bin.dart';
import 'package:msi_app/providers/staging_bin.provider.dart';
import 'package:msi_app/screens/staging_item/staging_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStaging extends StatelessWidget {
  final StagingBin item;

  const ItemStaging(this.item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StagingBinProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(StagingItemScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine(item.binCode, ''),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
          ],
        ),
      ),
    );
  }
}
