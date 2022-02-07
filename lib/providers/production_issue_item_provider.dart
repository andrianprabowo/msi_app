import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionIssueItemProvider with ChangeNotifier {
  List<ProductionIssueItemModel> _items;

  
  ProductionIssueItemModel _selected;

  ProductionIssueItemModel get selected => _selected;

  List<ProductionIssueItemModel> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.putQty;
        });
        detail.putQty = totalBatch;
      }

      // calculate remaining qty
      detail.remainingQty = detail.availableQty - detail.putQty;
      detail.totQty = detail.totQty + detail.putQty;
      
    });

    return _items;
  }

  Future<void> getItemInStagingBin(String pickNumber) async {
    final url =
        '$kBaseUrl/api/getplitemsbyIPno/docnum=$pickNumber';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionIssueItemModel> list = [];
      data.forEach((map) {
        list.add(ProductionIssueItemModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionIssueItemModel findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode && element.remainingQty>0);
  }

  void addBatchList(
    ProductionIssueItemModel productionIssueItemModel,
    List<ProductionIssueItemBatchModel> batchList,
  ) {
    productionIssueItemModel.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatchItem(
    ProductionIssueItemModel productionIssueItemModel,
    ProductionIssueItemBatchModel itemBatch,
  ) {
    productionIssueItemModel.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch Item: $itemBatch');
  }

  void inputQtyNonBatch(ProductionIssueItemModel productionIssueItemModel, double qty) {
    productionIssueItemModel.putQty = qty;
    notifyListeners();
    print('Update Qty Non batch: $ProductionIssueItemModel');
  }

   void selectPo(ProductionIssueItemModel purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }
}
