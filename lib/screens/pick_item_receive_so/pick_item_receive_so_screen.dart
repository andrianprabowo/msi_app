import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_whs_so.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_item_receive_so_provider.dart';
import 'package:msi_app/providers/pick_list_whs_so_provider.dart';
import 'package:msi_app/screens/pick_check_so/pick_check_so_screen.dart';
import 'package:msi_app/screens/pick_item_bin_so/pick_list_bin_so_screen.dart';
import 'package:msi_app/screens/pick_item_receive_so/widgets/item_pick_receive_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickItemReceiveSoScreen extends StatelessWidget {
  static const routeName = '/pick_item_receive_so';

  Future<void> refreshData(BuildContext context, String pickNumber) async {
    final pickItemProvider =
        Provider.of<PickItemReceiveSoProvider>(context, listen: false);
    await pickItemProvider.getPlActionByPlNo(pickNumber);

    final pickWhsProvider =
        Provider.of<PickListWhsSoProvider>(context, listen: false);
    pickWhsProvider.selected.pickItemList = pickItemProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    final item =
        Provider.of<PickListWhsSoProvider>(context, listen: false).selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List Sales Order'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () {
              authProvider.clearBin();
              Navigator.of(context).pushNamed(PickCheckSoScreen.routeName);
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
            BaseTextLine('SO Number', item.pickNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('SO Date', convertDate(item.pickDate)),
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

  Widget buildItemList(BuildContext context, PickListWhsSo item) {
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
            child: Consumer<PickItemReceiveSoProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemPickReceiveSo(provider.items[index]),
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
        Provider.of<PickItemReceiveSoProvider>(context, listen: false);
    return InputScan(
      label: 'Item Code',
      hint: 'Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        provider.selectItem(item);
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(PickListBinSoScreen.routeName, arguments: item)
            : Navigator.of(context)
                .pushNamed(PickListBinSoScreen.routeName, arguments: item);
      },
    );
  }
}
