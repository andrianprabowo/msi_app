import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/providers/item_batch_provider.dart';
import 'package:msi_app/screens/staging_batch/widgets/item_batch_staging.dart';
import 'package:msi_app/screens/staging_confirm/staging_confirm_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StagingBatchScreen extends StatelessWidget {
  static const routeName = '/staging_batch';

  final _inputQty = TextEditingController();

  Future<void> refreshData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    await Provider.of<ItemBatchProvider>(context, listen: false)
        .getBatchListByItemWarehouse(itemCode, binCode);
  }

  @override
  Widget build(BuildContext context) {
    ItemBin item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Put Away'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputQty(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
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

  Widget buildInputQty() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _inputQty,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Quantity',
        hintText: 'Input Quantity',
      ),
    );
  }

  Widget buildItemList(BuildContext context, ItemBin item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.itemCode, "item.binCode"),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () =>
                refreshData(context, item.itemCode, "item.binCode"),
            child: Consumer<ItemBatchProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemBatchStaging(provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ItemBatchProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Batch Number',
      scanResult: (value) {
        final item = provider.findBy(value);
        Navigator.of(context).pushNamed(
          StagingConfirmScreen.routeName,
          arguments: item,
        );
      },
    );
  }
}
