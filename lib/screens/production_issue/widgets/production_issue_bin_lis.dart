import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_model.dart';
import 'package:msi_app/providers/production_issue_provider.dart';
import 'package:msi_app/screens/production_issue_number/production_issue_number_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionIssueBinList extends StatelessWidget {
  final ProductionIssueModel item;

  const ProductionIssueBinList(this.item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductionIssueProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectProductionIssueModel(item);
        Navigator.of(context).pushNamed(ProductionIssueNumber.routeName);
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
