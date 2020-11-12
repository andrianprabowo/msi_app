import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_si.dart';
import 'package:msi_app/providers/item_batch_si_provider.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/stock_inquiry_batch/widgets/item_batch_staging_si.dart';
import 'package:msi_app/screens/stock_inquiry_header/stock_inquiry_header_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockInquiryBatchScreen extends StatelessWidget {
  static const routeName = '/stock_inquiry_batch_screen';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider = Provider.of<ItemBatchSiProvider>(context, listen: false);
    await provider.getBatchListByItemWarehouse(itemCode, binCode);
  }

  @override
  Widget build(BuildContext context) {
    final itemBatchProvider =
        Provider.of<ItemBatchSiProvider>(context, listen: false);
    ItemBinSi item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Inquiry Batch'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
               backToHome(context);
              
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // buildInputScan(context),
            // Row(
            //   children: [
            //     Consumer<ItemBatchSiProvider>(
            //         builder: (BuildContext _, provider, Widget child) {
            //       return Expanded(
            //         child: BaseTextLine(
            //           'Total Picked',
            //           provider.totalPicked.toStringAsFixed(2),
            //         ),
            //       );
            //     }),
            //     SizedBox(width: getProportionateScreenWidth(kLarge)),
            //     FlatButton.icon(
            //         onPressed: () {
            //           itemBatchProvider.clear();
            //         },
            //         icon: Icon(Icons.delete),
            //         color: Colors.red,
            //         label: Text('CLEAR'))
            //   ],
            // ),
            BaseTitle(item.itemCode),
            BaseTitle(item.itemName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, ItemBinSi item) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, item.itemCode, item.binCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ItemBatchSiProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemBatchStagingSi(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  void backToHome(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(''),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Inquiry Another Item'),
            onPressed: () => Navigator.of(context).pushNamed(
                StockInquiryHeaderScreen.routeName,
              )
          ),
          FlatButton(
            child: Text('Quit Module'),
            onPressed: () => Navigator.of(context).pushNamed(
                HomeScreen.routeName,
              )
          ),
        ],
      ),
    );
  }

  // Widget buildInputScan(BuildContext context) {
  //   final provider = Provider.of<ItemBatchSiProvider>(context, listen: false);
  //   return InputScan(
  //     label: 'Batch Number',
  //     hint: 'Input or scan Batch Number',
  //     scanResult: (value) {
  //       final item = provider.findByBatchNo(value);
  //       showModalBottomSheet(
  //         context: context,
  //         builder: (_) => DialogPutAwayRfo(item),
  //       );
  //     },
  //   );
  // }
}
