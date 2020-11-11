import 'package:flutter/material.dart';
import 'package:msi_app/models/staging_bin_si.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/staging_bin_si.provider.dart';
import 'package:msi_app/screens/stock_inquiry_detail/stock_inquiry_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStagingStockInquiry extends StatelessWidget {
  final StagingBinSi item;

  const ItemStagingStockInquiry(this.item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StagingBinSiProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(StockInquiryDetailScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(kTiny)),
            BaseTextLine(item.binCode, ''),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine(authProvider.warehouseName, ''),
            SizedBox(height: getProportionateScreenHeight(kTiny)),
          ],
        ),
      ),
    );
  }
}
