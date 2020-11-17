import 'package:flutter/material.dart';
import 'package:msi_app/models/barcode_grpo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ItemBarcodeGrpo extends StatelessWidget {
  final BarcodeGrpo item;

  const ItemBarcodeGrpo(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.of(context).pushNamed(StagingItemScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        height: 250,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          children: [
            SizedBox(width: getProportionateScreenWidth(kMedium)),
            BaseTitle(item.dscription),
            SizedBox(width: getProportionateScreenWidth(kMedium)),

            Expanded(
              child: SfBarcodeGenerator(
                value: item.itemCode,
                // symbology: QRCode(),
                showValue: true,
              ),
            ),
            Expanded(
              child: SfBarcodeGenerator(
                value: item.batchNo,
                // symbology: QRCode(),
                showValue: true,
              ),
            ),
            BaseTitle(convertDate(item.expDate)),
          ],
        ),
      ),
    );
  }
}
