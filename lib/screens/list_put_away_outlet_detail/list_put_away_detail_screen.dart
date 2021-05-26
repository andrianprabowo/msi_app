import 'package:flutter/material.dart';
import 'package:msi_app/models/list_put_away_rfo.dart';
import 'package:msi_app/providers/list_put_away_rfo_detail_provider.dart';
import 'package:msi_app/providers/list_put_away_rfo_provider.dart';
import 'package:msi_app/screens/list_put_away_outlet_detail/widgets/item_list_put_away_outlet_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListPutAwayOutletDetailScreen extends StatelessWidget {
  static const routeName = '/list_put_away_outlet_detail';

  Future<void> refreshData(BuildContext context, ListPutAwayRfo item) async {
    await Provider.of<ListPutAwayRfoDetailProvider>(context, listen: false)
        .getAllData(item.idPwyrtoHeader);
  }

  @override
  Widget build(BuildContext context) {
    final detail =
        Provider.of<ListPutAwayRfoProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Put Away From Outlet'),
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

  Widget buildItemList(BuildContext context, ListPutAwayRfo itemPo) {
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
            child: Consumer<ListPutAwayRfoDetailProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemListPutAwayOutletDetail(
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
