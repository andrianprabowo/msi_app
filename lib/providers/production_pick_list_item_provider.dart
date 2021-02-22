import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionPickListItemProvider with ChangeNotifier {
  List<ProductionPickListItemModel> _items;

  List<ProductionPickListItemModel> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
        detail.quantity = detail.openQty - detail.pickedQty;
      } else {
        // calculate remaining qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
        detail.quantity = detail.openQty - detail.pickedQty;
      }
    });

    // _items = _items.where((item) => item.quantity > 0).toList();

    return _items;
  }

  Future<void> getPlActionByPlNo(String pickNumber) async {
    final url = '$kBaseUrl/api/getplitemsbyPRMnoitem/docnum=$pickNumber';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionPickListItemModel> list = [];
      data.forEach((map) {
        list.add(ProductionPickListItemModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionPickListItemModel findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    ProductionPickListItemModel productionPickListItemModel,
    List<ProductionPickListItemBatchModel> batchList,
  ) {
    productionPickListItemModel.batchList.addAll(batchList);
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void addBin(
    ProductionPickListItemModel productionPickListItemModel,
    ProductionPickListItemBatchModel batchList,
  ) {
    productionPickListItemModel.batchList.add(batchList);
    notifyListeners();
    print('Added Bin List: $batchList');
  }

  void removeBatchItem(
    ProductionPickListItemModel productionPickListItemModel,
    ProductionPickListItemBatchModel itemBatch,
  ) {
    productionPickListItemModel.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Item Batch: $itemBatch');
  }

  void updateQtyNBinNonBatch(
      ProductionPickListItemModel productionPickListItemModel, double qty) {
    productionPickListItemModel.pickedQty = qty;
    // productionPickListItemModel.itemStorageLocation = bin;
    notifyListeners();
    print('Update Qty & Bin Loc Non batch: $productionPickListItemModel');
  }
}
