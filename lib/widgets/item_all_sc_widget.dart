import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/stock_counting_batch/stock_counting_batch_screen.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_non_batch_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

class ItemAllScWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return FutureBuilder(
      future: authProvider.getData(),
      builder: (_, snapshot) {
        return Row(
          children: [
            buildTextInfo(authProvider),
            Spacer(),
            buildChangeBin(context),
          ],
        );
      },
    );
  }

  Widget buildTextInfo(AuthProvider authProvider) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Item :',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChangeBin(BuildContext context) {
    final stockCountprovider =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // final poProvider =
    //     Provider.of<StockCountingItemProvider>(context, listen: false);
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        // await stockCountprovider.getAllItems();
        SelectDialog.showModal<StockCountingItem>(
          context,
          label: "Search Item",
          showSearchBox: true,
          items: stockCountprovider.allItems,
          // print('object dari item${item.itemCode}');

          itemBuilder: (context, item, _) {
            // return ListTile(
            //   title: Text(item.itemCode),
            //   subtitle: Text(item.description),
            // );
            return InkWell(
              onTap: () {
                if (item.fgBatch == 'Y') {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                      StockCountingBatchScreen.routeName,
                      arguments: item);

                  // Navigator.of(context)
                  //     .pushNamed(StockCountingBatchScreen.routeName, arguments: item);
                } else {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => DialogInputQtyNonBatchSc(item));
                }
              },
              child: Container(
                margin: const EdgeInsets.all(kTiny),
                padding: const EdgeInsets.all(kMedium),
                decoration: kBoxDecoration,
                child: Column(
                  children: [
                    Text(
                      item.itemCode,
                    ),
                    Text(item.description, overflow: TextOverflow.ellipsis),
                    // BaseTextLine('Counter Assign', authProvider.username),
                    // BaseTextLine('Warehouse', authProvider.warehouseName)
                  ],
                ),
              ),
            );
          },

          searchBoxDecoration:
              InputDecoration(hintText: 'Search by name or ID'),
          // onChange: (StockCountingItem stockCountItem) {
          //   // authProvider.selectBin(stockCountItem);
          //   // stockCountprovider.setItemCode(stockCountItem.toString());
          // },

          // onTap: (StockCountingItem stockCountItem) {
          //   // authProvider.selectBin(stockCountItem);
          //   // stockCountprovider.setItemCode(stockCountItem.toString());
          // },
        );
      },
    );
  }
}
