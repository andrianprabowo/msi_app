import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/models/production_issue_item_change_model.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemChangeProvider with ChangeNotifier {
  List<ProductionIssueItemChangeModel> _items;

  ProductionIssueItemChangeModel _selected;

  ProductionIssueItemChangeModel get selected => _selected;

  List<ProductionIssueItemChangeModel> get items {
    _items.forEach((detail) {
      // if (detail.fgBatch == "Y") {
      //   // calculate total batch qty
      //   var totalBatch = 0.0;
      //   detail.batchList.forEach((batch) {
      //     totalBatch = totalBatch + batch.putQty;
      //   });
      //   detail.putQty = totalBatch;
      // }

      // calculate remaining qty
      // detail.remainingQty = detail.availableQty - detail.putQty;
      // detail.totQty = detail.totQty + detail.putQty;
    });

    return _items;
  }

  Future<void> getItemChange(BuildContext context, String itemCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final cc = Provider.of<ProductionIssueItemProvider>(context, listen: false);
    final sel = cc.selected.itemCode;

    final url =
        '$kBaseUrl/api/changeItemIssue/itemcode=$sel&whscode=$warehouseId';
    print('itemCode');
    print(itemCode);
    print('itemCode');

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionIssueItemChangeModel> list = [];
      data.forEach((map) {
        list.add(ProductionIssueItemChangeModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionIssueItemChangeModel findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    ProductionIssueItemChangeModel productionIssueItemChangeModel,
    List<ProductionIssueItemBatchModel> batchList,
  ) {
    productionIssueItemChangeModel.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatchItem(
    ProductionIssueItemChangeModel productionIssueItemChangeModel,
    ProductionIssueItemBatchModel itemBatch,
  ) {
    productionIssueItemChangeModel.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch Item: $itemBatch');
  }

  // void inputQtyNonBatch(
  //     ProductionIssueItemChangeModel productionIssueItemChangeModel,
  //     double qty) {
  //   productionIssueItemChangeModel.putQty = qty;
  //   notifyListeners();
  //   print('Update Qty Non batch: $ProductionIssueItemChangeModel');
  // }

  void selectPo(ProductionIssueItemChangeModel purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }
}
