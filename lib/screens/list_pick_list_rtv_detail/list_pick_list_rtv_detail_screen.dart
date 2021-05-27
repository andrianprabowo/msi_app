import 'package:flutter/material.dart';
import 'package:msi_app/models/list_pick_list_rtv.dart';
import 'package:msi_app/providers/list_pick_list_rtv_detail_provider.dart';
import 'package:msi_app/providers/list_pick_list_rtv_provider.dart';
import 'package:msi_app/screens/list_pick_list_rtv_detail/widgets/item_list_pick_list_rtv_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListPickListRtvDetailScreen extends StatelessWidget {
  static const routeName = '/list_pick_list_rtv_detail';

  Future<void> refreshData(BuildContext context, ListPickListRtv item) async {
    await Provider.of<ListPickListRtvDetailProvider>(context, listen: false)
        .getAllData(item.idRvplHeader);
  }

  @override
  Widget build(BuildContext context) {
    final detail =
        Provider.of<ListPickListRtvProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Pick List Rtv'),
        actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             BaseTitle('Cancel This Transaction'),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
           
            // Divider(),
            buildItemList(context, detail),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, ListPickListRtv itemPo) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, itemPo),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, itemPo),
            child: Consumer<ListPickListRtvDetailProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemListPickListRtvDetail(
                              provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
