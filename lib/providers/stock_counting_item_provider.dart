import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class StockCountingItemProvider with ChangeNotifier {
  List<StockCountingItem> _item;
  // StockCountingItem _selected;

  List<StockCountingItem> get item {
    _item.forEach((detail) {
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


    // _item = _item.where((item) => item.remainingQty > 0).toList();

    return _item;
  }

  Future<void> getScDetailByDocNum(String docNum) async {
    final url =
        '$kBaseUrl/api/getstcdetail/docnum=$docNum';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print('isi data item $data');
      if (data == null) return;

      final List<StockCountingItem> list = [];
      data.forEach((map) {
        list.add(StockCountingItem.fromMap(map));
      });

      _item = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StockCountingItem findByItemCode(String itemCode) {
    return _item.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatch(StockCountingItem itemPo, ItemBatch itemBatch) {
    itemPo.batchList.add(itemBatch);
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void removeBatch(StockCountingItem itemPo, ItemBatch itemBatch) {
    itemPo.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch: $itemBatch');
  }

  void inputQty(StockCountingItem itemPo, double qty) {
    itemPo.quantity = qty;
    notifyListeners();
    print('Update Qty: $itemPo');
  }
}
