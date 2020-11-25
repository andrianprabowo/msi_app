import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_number_model.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/screens/production_issue_item/production_issue_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionIssueNumberList extends StatelessWidget {
  final ProductionIssueNumberModel item;

  const ProductionIssueNumberList(this.item);

  @override
  Widget build(BuildContext context) {
    final issueNumberProvider =
        Provider.of<ProductionIssueNumberProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        issueNumberProvider.selectPickList(item);
        Navigator.of(context).pushNamed(ProductionIssueItem.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Transaction Number', item.pickNumber),
            BaseTextLine('Transaction Date', convertDate(item.pickDate)),
            BaseTextLine('Whs Code', item.plant),
            BaseTextLine('Whs Name', item.plantName),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}