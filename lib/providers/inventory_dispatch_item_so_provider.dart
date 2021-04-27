import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_batch_so.dart';
import 'package:msi_app/models/inventory_dispatch_item_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class InventoryDispatchItemSoProvider with ChangeNotifier {
  List<InventoryDispatchItemSo> _items;

  List<InventoryDispatchItemSo> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
      }
      // calculate remaining qty
      detail.quantity = detail.openQty - detail.pickedQty;
    });

    // _items = _items.where((item) => item.quantity > 0).toList();

    return _items;
  }

  Future<void> getInventItemByPlNo(String docNumber) async {

    final url = '$kBaseUrl/api/getplitemsbySOIDPno/docnum=$docNumber';
    // final url = '$kBaseUrl/api/getplitemsbyIDPno/docnum=MS2020070000007';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<InventoryDispatchItemSo> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchItemSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchItemSo findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    InventoryDispatchItemSo inventoryDispatchItem,
    List<InventoryDispatchBatchSo> batchList,
  ) {
    inventoryDispatchItem.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatchItem(
    InventoryDispatchItemSo inventoryDispatchItem,
    InventoryDispatchBatchSo itemBatch,
  ) {
    inventoryDispatchItem.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Item Batch: $itemBatch');
  }

  void inputQtyNonBatch(InventoryDispatchItemSo inventoryDispatchItem, double qty ) {
    inventoryDispatchItem.pickedQty = qty;
    // inventoryDispatchItem.itemStorageLocation = itemStorageLocation;
    notifyListeners();
    print('Update Qty Non batch: $inventoryDispatchItem');
  }

  
  void inputBinNonBatch(InventoryDispatchItemSo inventoryDispatchItem, String itemStorageLocation) {
    // inventoryDispatchItem.pickedQty = qty;
    inventoryDispatchItem.itemStorageLocation = itemStorageLocation;
    notifyListeners();
    print('Update Bin Non batch: $inventoryDispatchItem');
  }
}
