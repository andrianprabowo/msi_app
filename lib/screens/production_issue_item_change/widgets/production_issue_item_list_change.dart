import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_change_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_change_provider.dart';
import 'package:msi_app/screens/production_issue_item_change/widgets/production_issue_item_change_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemListChange extends StatelessWidget {
  final ProductionIssueItemChangeModel item;

  const ProductionIssueItemListChange(this.item);

  @override
  Widget build(BuildContext context) {
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
     final listProvider =
        Provider.of<ProductionIssueItemChangeProvider>(context, listen: false);
   
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        
          listProvider.selectPo(item);
         showModalBottomSheet(
                context: context,
                builder: (_) => ProductionIssueItemChangeDialog(item));
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
             
            BaseTitle(item.itemCode),
            BaseTitle(item.itemName),

          ],
        ),
      ),
    );
  }

 


}
