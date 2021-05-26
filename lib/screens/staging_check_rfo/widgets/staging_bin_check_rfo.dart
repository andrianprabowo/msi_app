import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class StagingBinCheckRfo extends StatelessWidget {
  final PutBatchRfo item;

  const StagingBinCheckRfo(this.item);

  @override
  Widget build(BuildContext context) {
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.bin),
          BaseTextLine(
              'Put Qty',
              item.putQty == 0.0
                  ? item.putQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.putQty)),
        ],
      ),
    );
  }
}
