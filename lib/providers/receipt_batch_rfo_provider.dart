import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ReceiptBatchRfoProvider with ChangeNotifier {
  List<ItemBatchRfo> _items = [];
  double _totalPicked = 0.0;

  List<ItemBatchRfo> get items {
    return _items.where((item) => item.availableQty > item.putQty).toList();
  }

  List<ItemBatchRfo> get pickedItems {
    return _items.where((item) => item.putQty > 0).toList();
  }

  double get totalPicked => _totalPicked;

  Future<void> getBatchListByItemWarehouse(
    String itemCode,
    String cardCode,
  ) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/getRTOIDPbatchlistbyitmwhs/itemcode=$itemCode&whscode=$warehouseId';
    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemBatchRfo> list = [];
      data.forEach((map) {
        list.add(ItemBatchRfo.fromMap(map));
      });

      _items = list;

      countTotal();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ItemBatchRfo findByBatchNo(String batchNo) {
    return _items.firstWhere((element) => element.batchNo == batchNo);
  }

  void updatePickQty(String batchNo, double putQty) {
    ItemBatchRfo item = _items.where((item) => item.batchNo == batchNo).first;
    if (item != null) {
      item.putQty = putQty;
    }

    countTotal();
    notifyListeners();
  }

  void clear() {
    _items.forEach((item) => item.putQty = 0.0);

    countTotal();
    notifyListeners();
  }

  void countTotal() {
    var total = 0.0;
    _items.forEach((item) {
      total = total + item.putQty;
    });

    _totalPicked = total;
    notifyListeners();
  }
}
