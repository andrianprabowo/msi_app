import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/screens/staging_confirm/staging_confirm_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemBatchStaging extends StatelessWidget {
  final ItemBatch item;

  const ItemBatchStaging(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          StagingConfirmScreen.routeName,
          arguments: item,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch Number', item.batchNo),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(2)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          ],
        ),
      ),
    );
  }
}
