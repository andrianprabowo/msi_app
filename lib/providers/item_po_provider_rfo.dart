import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch_rfo.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ItemPoRfoProvider with ChangeNotifier {
  List<ItemPurchaseOrderRfo> _items;

  List<ItemPurchaseOrderRfo> get items {
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

    _items = _items.where((item) => item.remainingQty > 0).toList();

    return _items;
  }

  Future<void> getPoDetailByDocNum(String docNum) async {
    //GetRTODetail
    final url = '$kBaseUrl/api/GetRTODetail/docnum=$docNum';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemPurchaseOrderRfo> list = [];
      data.forEach((map) {
        list.add(ItemPurchaseOrderRfo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ItemPurchaseOrderRfo findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatch(ItemPurchaseOrderRfo itemPo, ItemBatchRfo itemBatch) {
    itemPo.batchList.add(itemBatch);
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void addBatchList(
    ItemPurchaseOrderRfo pickItemReceive,
    List<ItemBatchRfo> batchList,
  ) {
    pickItemReceive.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatch(ItemPurchaseOrderRfo itemPo, ItemBatchRfo itemBatch) {
    itemPo.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch: $itemBatch');
  }

  void inputQty(ItemPurchaseOrderRfo itemPo, double qty) {
    itemPo.quantity = qty;
    notifyListeners();
    print('Update Qty: $itemPo');
  }
}
