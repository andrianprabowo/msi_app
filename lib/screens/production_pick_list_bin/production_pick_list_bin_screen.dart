import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/providers/production_pick_list_bin_provider.dart';
import 'package:msi_app/providers/production_pick_list_provider.dart';
import 'package:msi_app/screens/production_pick_list_bin/widget/production_pick_list_bin_list.dart';
import 'package:msi_app/screens/production_pick_list_item/widgets/production_pick_list_item_non_batch_dialog.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/production_pick_list_item_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

/* class ProductionPickListBin extends StatefulWidget {
  static const routeName = '/production_pick_list_bin';
  @override
  _ProductionPickListBinState createState() => _ProductionPickListBinState();
}

class _ProductionPickListBinState extends State<ProductionPickListBin> {
  bool switchControl = false;
  Future<void> refreshData(BuildContext context, String itemCode) async {
    final pickItemProvider =
        Provider.of<ProductionPickListBinProvider>(context, listen: false);
    await pickItemProvider.getPlBinList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickList =
        Provider.of<ProductionPickListProvider>(context, listen: false)
            .selected;
    ProductionPickListItemModel productionPickListItemModel =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Production Pick List'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Recommendation Bin', ''),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Memo', pickList.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            if(switchControl) 
              buildInputScan(context, productionPickListItemModel),
            //SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Bin Location'),
                ),
                Text('Show All Bin'),
                Consumer<ProductionPickListBinProvider>(
                  builder: (_, provider, child) {
                    return Switch(
                      value: switchControl,
                      onChanged: (value) {
                        provider.toggleStatus();
                        if (value) {
                          setState(() {
                            switchControl = value;
                          });
                        } else {
                          setState(() {
                            switchControl = value;
                          });
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            Divider(),
            buildItemList(context, productionPickListItemModel, switchControl),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context,
      ProductionPickListItemModel productionPickListItemModel) {
    final provider =
        Provider.of<ProductionPickListBinProvider>(context, listen: false);
    final pickItemListProvider =
        Provider.of<ProductionPickListItemProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findByBinLocation(value.toUpperCase());
        pickItemListProvider.updateQtyNBinNonBatch(
                productionPickListItemModel,
                double.parse(productionPickListItemModel.pickedQty.toString()),
                item.binLocation);
        productionPickListItemModel.fgBatch == "Y"
            ? Navigator.of(context).pushNamed(
                ProductionPickListItemBatch.routeName,
                arguments: {
                  'productionPickListItemModel': productionPickListItemModel,
                  'pickListBin': item,
                },
              )
            : Navigator.of(context).popUntil(
                ModalRoute.withName(ProductionPickListItem.routeName));
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionPickListItemModel item,
      bool toggleSwitch) {
    if (toggleSwitch) {
      return Expanded(
        child: FutureBuilder(
          future: refreshData(context, item.itemCode),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) return ErrorInfo();

            return RefreshIndicator(
              onRefresh: () => refreshData(context, item.itemCode),
              child: Consumer<ProductionPickListBinProvider>(
                builder: (_, provider, child) => provider.items.length == 0
                    ? NoData()
                    : ListView.builder(
                        itemCount: provider.items.length,
                        itemBuilder: (_, index) {
                          return ChangeNotifierProvider.value(
                            value: provider.items[index],
                            child: ProductionPickListBinList(
                                item, provider.items[index]),
                          );
                        },
                      ),
              ),
            );
          },
        ),
      );
    } else {
      return Text('');
    }
  }
} */

class ProductionPickListBin extends StatelessWidget {
  static const routeName = '/production_pick_list_bin';

  Future<void> refreshData(BuildContext context, String itemCode) async {
    final pickItemProvider =
        Provider.of<ProductionPickListBinProvider>(context, listen: false);
    await pickItemProvider.getPlBinList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickList =
        Provider.of<ProductionPickListProvider>(context, listen: false)
            .selected;
    ProductionPickListItemModel productionPickListItemModel =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick List'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProductionPickListBinProvider>(
              builder: (_, provider, child) {
                String binLoc = provider.recBin ?? '';
                return BaseTextLine('Recom Bin', binLoc);
              },
            ),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Memo', pickList.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context, productionPickListItemModel),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Bin Location'),
                ),
                /* Text('Show All Bin'),
                Consumer<ProductionPickListBinProvider>(
                  builder: (_, provider, child) {
                    return Switch(
                      value: provider.showAllBin,
                      onChanged: (value) {
                        provider.toggleStatus();
                      },
                    );
                  },
                ), */
              ],
            ),
            Divider(),
            buildItemList(context, productionPickListItemModel),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context,
      ProductionPickListItemModel productionPickListItemModel) {
    final provider =
        Provider.of<ProductionPickListBinProvider>(context, listen: false);
    // final pickItemListProvider =
    //     Provider.of<ProductionPickListItemProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findByBinLocation(value.toUpperCase());
        if (productionPickListItemModel.fgBatch == "Y") {
          productionPickListItemModel.itemStorageLocation = item.binLocation;
          Navigator.of(context).pushNamed(
            ProductionPickListItemBatch.routeName,
            arguments: {
              'productionPickListItemModel': productionPickListItemModel,
              'pickListBin': item,
            },
          );
        } else {
          // pickItemListProvider.updateQtyNBinNonBatch(
          //     productionPickListItemModel,
          //     double.parse(productionPickListItemModel.pickedQty.toString()),
          //     item.binLocation);
          // Navigator.of(context)
          //     .popUntil(ModalRoute.withName(ProductionPickListItem.routeName));
        
          // update bin location
          productionPickListItemModel.itemStorageLocation = item.binLocation;
          showModalBottomSheet(
              context: context,
              builder: (_) => ProductionPickListItemNonBatchDialog(productionPickListItemModel));
        }
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionPickListItemModel item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.itemCode),
            child: Consumer<ProductionPickListBinProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ProductionPickListBinList(
                              item, provider.items[index]),
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
