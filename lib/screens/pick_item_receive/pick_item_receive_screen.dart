import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_item_receive_provider.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:msi_app/screens/pick_check/pick_check_screen.dart';
import 'package:msi_app/screens/pick_item_bin/pick_list_bin_screen.dart';
import 'package:msi_app/screens/pick_item_receive/widgets/item_pick_receive.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickItemReceiveScreen extends StatelessWidget {
  static const routeName = '/pick_item_receive';

  Future<void> refreshData(BuildContext context, String pickNumber) async {
    final pickItemProvider =
        Provider.of<PickItemReceiveProvider>(context, listen: false);
    await pickItemProvider.getPlActionByPlNo(pickNumber);

    final pickWhsProvider =
        Provider.of<PickListWhsProvider>(context, listen: false);
    pickWhsProvider.selected.pickItemList = pickItemProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    final item =
        Provider.of<PickListWhsProvider>(context, listen: false).selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () {
              authProvider.clearBin();
              Navigator.of(context).pushNamed(PickCheckScreen.routeName);
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
            BaseTextLine('Pick Number', item.pickNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Pick Date', convertDate(item.pickDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Remarks', item.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, PickListWhs item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.pickNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.pickNumber),
            child: Consumer<PickItemReceiveProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemPickReceive(provider.items[index]),
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
    final provider =
        Provider.of<PickItemReceiveProvider>(context, listen: false);
    return InputScan(
      label: 'Item Code',
      hint: 'Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        provider.selectItem(item);
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(PickListBinScreen.routeName, arguments: item)
            : Navigator.of(context)
                .pushNamed(PickListBinScreen.routeName, arguments: item);
      },
    );
  }
}
