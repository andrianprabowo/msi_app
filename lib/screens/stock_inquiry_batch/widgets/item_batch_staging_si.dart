import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch_si.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemBatchStagingSi extends StatelessWidget {
  final PutBatchSi item;

  const ItemBatchStagingSi(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   showModalBottomSheet(
      //     context: context,
      //     builder: (_) => DialogPutAwayRfo(item),
      //   );
      // },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch Number', item.batchNo),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(2)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Put Qty', item.putQty.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
