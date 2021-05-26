import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_bin_rfo.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/item_bin_rfo_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class PutBinWidgetRfo extends StatelessWidget {
  final ItemBinRfo item;
  final PutBatchRfo batch;

  const PutBinWidgetRfo(this.item, this.batch);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final provider = Provider.of<ItemBinRfoProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeBatchItem(item, batch);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTitle(batch.bin),
                BaseTextLine('Quantity',
                    batch.putQty == 0.0
                        ? batch.putQty.toStringAsFixed(authProvider.decLen)
                        : formatter.format(batch.putQty)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
