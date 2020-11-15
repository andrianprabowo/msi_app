import 'package:flutter/material.dart';
import 'package:msi_app/providers/pick_list_whs_so_provider.dart';
import 'package:msi_app/screens/list_pick_list_so/list_pick_list_so_screen.dart';
import 'package:msi_app/screens/pick_item_receive_so/pick_item_receive_so_screen.dart';
import 'package:msi_app/screens/picker_pick_so/widgets/item_pick_list_whs_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickerPickSoScreen extends StatelessWidget {
  static const routeName = '/picker_pick_so';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<PickListWhsSoProvider>(context, listen: false)
        .getPlByWarehouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List Sales Order'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ListPickListSoScreen.routeName);
            },
          ),
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
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('Pick & Pack List'),
            Divider(),
            buildItemList(context),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context),
            child: Consumer<PickListWhsSoProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemPickListWhsSo(provider.items[index]),
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
    final provider = Provider.of<PickListWhsSoProvider>(context, listen: false);
    return InputScan(
      label: 'Pick Number',
      hint: 'Input or scan Pick Number',
      scanResult: (value) {
        final item = provider.findByPickNumber(value);
        provider.selectPickList(item);
        Navigator.of(context).pushNamed(PickItemReceiveSoScreen.routeName);
      },
    );
  }
}
