import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/screens/production_issue_item/widgets/production_issue_item_batch_box.dart';
import 'package:msi_app/screens/production_issue_item/widgets/production_issue_item_non_batch_dialog.dart';
import 'package:msi_app/screens/production_issue_item_batch/production_issue_item_batch_screen.dart';
import 'package:msi_app/screens/production_issue_item_change/production_issue_item_change_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

import '../production_issue_item_screen.dart';

class ProductionIssueItemList extends StatelessWidget {
  final ProductionIssueItemModel item;

  const ProductionIssueItemList(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        if (item.fgBatch == 'Y') {
          Navigator.of(context)
              .pushNamed(ProductionIssueItemBatch.routeName, arguments: item);
        } else {
              if(item.putQty > 0){
             print('masuk');
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {

                return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, color: Colors.red, size: 50),
                        Divider(),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        Text('You Already Put Qty'),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        Text(item.putQty.toString()),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        Text('You want to re-enter qty ?'),

                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('Put New Qty'),
                            onPressed: () {
                               final itemNumberProvider =
                  Provider.of<ProductionIssueNumberProvider>(context,
                      listen: false);
           itemNumberProvider.selected.totalItem =
                    itemNumberProvider.selected.totalItem  +
                        1;
                               Navigator.of(context).pop();
                              showModalBottomSheet(
                              context: context,
                              builder: (_) => ProductionIssueItemNonBatchDialog(item));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                  },
              );

              }else{
                  showModalBottomSheet(
                  context: context,
                  builder: (_) => ProductionIssueItemNonBatchDialog(item));
              }
          
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            if (item.oldItemCode != '') BaseTitleColor(item.oldItemCode),
            if (item.oldItemName != '') BaseTitleColor(item.oldItemName),
            BaseTitle(item.itemCode),
            BaseTitle(item.itemName),
            Divider(),

            BaseTextLine('Item Batch', item.fgBatch),
            // BaseTextLine('Item Batch', item.line),

            BaseTextLine(
                'Planned Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.availableQty)),
            BaseTextLine('UOM', item.unitMsr),
            BaseTextLine(
                'Remaining Qty',
                item.remainingQty == 0.0
                    ? item.remainingQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.remainingQty)),
            if (item.putQty != 0)
              BaseTextLine(
                  'Put Qty',
                  item.putQty == 0.0
                      ? item.putQty.toStringAsFixed(authProvider.decLen)
                      : formatter.format(item.putQty)),
            if (item.canChangeitem == 'Y' && item.putQty == 0)
              buildButtonChange(context, item.itemCode),
            //  print('kirim');
            //  print(item.itemCode);
            //  print('kirim');
            if (item.canChangeitem == 'Y' && item.putQty == 0)
              buildButtonRefresh(context, '2'),

            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<ProductionIssueItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionIssueItemBatchBox(item, list[index]);
      },
    );
  }

  Widget buildButtonChange(BuildContext context, String itemCode) {
    final listProvider =
        Provider.of<ProductionIssueItemProvider>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Change Item'),
        onPressed: () {
          listProvider.selectPo(item);
          print('kirim' + itemCode);
          Navigator.of(context)
              .pushNamed(ProductionIssueItemChange.routeName, arguments: item);
        },
      ),
    );
  }

  Widget buildButtonRefresh(BuildContext context, String avlQty) {
    final listProvider =
        Provider.of<ProductionIssueItemProvider>(context, listen: false);
    return Row(
      children: [
        // BaseTitle ('List Items'),
        // SizedBox(width: getProportionateScreenWidth(kLarge)),
        FlatButton.icon(
            onPressed: () {
              listProvider.selectPo(item);
              Navigator.of(context).pushNamed(
                  ProductionIssueItemChange.routeName,
                  arguments: item);

              Navigator.of(context)
                  .popUntil(ModalRoute.withName(ProductionIssueItem.routeName));
            },
            icon: Icon(Icons.refresh),
            // color: Colors.red,
            label: Text('Refresh'))
      ],
    );
  }
}
