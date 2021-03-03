import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ItemPoProvider with ChangeNotifier {
  List<ItemPurchaseOrder> _items;

  List<ItemPurchaseOrder> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == 'Y') {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.availableQty;
        });
        detail.quantity = totalBatch;
      }
      // calculate remaining qty
      detail.remainingQty = detail.openQty - detail.quantity;
    });

    // _items = _items.where((item) => item.remainingQty > 0).toList();

    return _items;
  }

  Future<void> getPoDetailByDocNum(String docNum) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);

    final url = '$kBaseUrl/api/newgetpodetail/docnum=$docNum&whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemPurchaseOrder> list = [];
      data.forEach((map) {
        list.add(ItemPurchaseOrder.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ItemPurchaseOrder findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatch(ItemPurchaseOrder itemPo, ItemBatch itemBatch) {
    itemPo.batchList.add(itemBatch);
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void removeBatch(ItemPurchaseOrder itemPo, ItemBatch itemBatch) {
    itemPo.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch: $itemBatch');
  }

  void inputQty(ItemPurchaseOrder itemPo, double qty) {
    itemPo.quantity = qty;
    notifyListeners();
    print('Update Qty: $itemPo');
  }
}
