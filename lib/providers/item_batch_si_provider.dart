import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch_si.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ItemBatchSiProvider with ChangeNotifier {
  List<PutBatchSi> _items = [];
  double _totalPicked = 0.0;

  List<PutBatchSi> get items {
    return _items.where((item) => item.availableQty > item.putQty).toList();
  }

  List<PutBatchSi> get pickedItems {
    return _items.where((item) => item.putQty > 0).toList();
  }

  double get totalPicked => _totalPicked;

  Future<void> getBatchListByItemWarehouse(
    String itemCode,
    String binCode,
  ) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/getplbatchlistbyitmwhs/itemcode=$itemCode&whscode=$warehouseId&bincode=$binCode';
    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PutBatchSi> list = [];
      data.forEach((map) {
        list.add(PutBatchSi.fromMap(map));
      });

      _items = list;

      countTotal();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PutBatchSi findByBatchNo(String batchNo) {
    return _items.firstWhere((element) => element.batchNo == batchNo);
  }

  void updatePickQty(String batchNo, double putQty) {
    PutBatchSi item = _items.where((item) => item.batchNo == batchNo).first;
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
