import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_bin_list_model.dart';
import 'package:msi_app/providers/production_receipt_rm_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_number/production_receipt_rm_number_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMBinList extends StatelessWidget {
  final ProductionReceiptRMBinListModel item;

  const ProductionReceiptRMBinList(this.item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductionReceiptRMProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(ProductionReceiptRMNumber.routeName);
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
