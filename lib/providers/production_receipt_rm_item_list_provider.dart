import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_batch_list_model.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionReceiptRMItemListProvider with ChangeNotifier {
  List<ProductionReceiptRMItemListModel> _items;
  ProductionReceiptRMItemListModel _selected;
  ProductionReceiptRMItemListModel get selected => _selected;

  List<ProductionReceiptRMItemListModel> get items {
    _items.forEach((detail) {
      // if (detail.fgBatch == "Y") {
      // calculate total batch qty
      var totalBatch = 0.0;
      detail.batchList.forEach((batch) {
        totalBatch = totalBatch + batch.pickQty;
      });
      detail.pickedQty = totalBatch;
      // }
      // calculate remaining qty
      detail.quantity = detail.openQty - detail.pickedQty;
    });

    // _items = _items.where((item) => item.quantity > 0).toList();

    return _items;
  }

  Future<void> getInventItemByPlNo(String docNumber) async {
    final url =
        '$kBaseUrl/api/getplitemsbyPAPRMno/docnum=$docNumber'; ////getplitemsbyPAPRMno

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptRMItemListModel> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptRMItemListModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

void selectItem(ProductionReceiptRMItemListModel purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  ProductionReceiptRMItemListModel findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    ProductionReceiptRMItemListModel inventoryDispatchItem,
    List<ProductionReceiptRMItemListBatchListModel> batchList,
  ) {
    inventoryDispatchItem.batchList.addAll(batchList);
    notifyListeners();
    print('Added Batch? List: $batchList');
  }

  void addBin(
    ProductionReceiptRMItemListModel inventoryDispatchItem,
    ProductionReceiptRMItemListBatchListModel batchList,
  ) {
    inventoryDispatchItem.batchList.add(batchList);
    notifyListeners();
    print('Added bin List: $batchList');
  }

  void removeBatchItem(
    ProductionReceiptRMItemListModel inventoryDispatchItem,
    ProductionReceiptRMItemListBatchListModel itemBatch,
  ) {
    inventoryDispatchItem.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Item Batch: $itemBatch');
  }

  void inputQtyNonBatch(ProductionReceiptRMItemListModel inventoryDispatchItem,
      double qty, String itemStorageLocation) {
    inventoryDispatchItem.pickedQty = qty;
    inventoryDispatchItem.itemStorageLocation = itemStorageLocation;
    notifyListeners();
    print('Update Qty Non batch: $inventoryDispatchItem');
  }
}
