import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickBatchProvider with ChangeNotifier {
  List<PickBatch> _items = [];
  double _totalPicked = 0.0;
  var _showAllItem = false;
  final fieldText = TextEditingController();


  bool get showAllItem => _showAllItem;

   void clearText() {
    fieldText.clear();
  }

  void toggleStatus() {
    _showAllItem = !_showAllItem;
    notifyListeners();
  }

  int _show = 1;

  List<PickBatch> get items {
    var show = 1;
    var totalRemain = 1;

    _items.forEach((item) {
      if (item.remainQty == 0) {
        item.totalRemain = totalRemain;
        item.show = show;
        totalRemain = totalRemain + 1;
        show = show + 1;
      }
    });
    _show = show;
    _items.forEach((detail) {
      // calculate remaining qty
      detail.remainQty = detail.availableQty - detail.pickQty;
    });

    // return _items.take(show).toList();
    return _showAllItem ? _items : _items.take(show).toList();

    // return _items;
    // return _items.where((item) => item.availableQty > item.pickQty).toList();
  }

  List<PickBatch> get pickedItems {
    return _items.where((item) => item.pickQty > 0).toList();
  }

  double get totalPicked => _totalPicked;
  int get totalShow => _show;

  Future<void> getPlBatchByItemWhs(String itemCode, String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/getplbatchlistbyitmwhs/itemcode=$itemCode&whscode=$warehouseId&bincode=$binCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickBatch> list = [];
      data.forEach((map) {
        list.add(PickBatch.fromMap(map));
      });

      _items = list;

      countTotal();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickBatch findByBatchNo(String batchNo) {
    return _items.firstWhere((item) => item.batchNo == batchNo);
  }

  void updatePickQty(String batchNo, double pickQty) {
    PickBatch item = _items.where((item) => item.batchNo == batchNo).first;
    if (item != null) {
      item.pickQty = pickQty;
      item.pickQty = pickQty;
    }

    countTotal();
    notifyListeners();
  }

  void    clear() {
    _items.forEach((item) => item.pickQty = 0.0);

    countTotal();
    notifyListeners();
  }

  void countTotal() {
    var total = 0.0;
    _items.forEach((item) {
      total = total + item.pickQty;
    });

    _totalPicked = total;
    notifyListeners();
  }

  // void countRemain() {
  //   var total = 0.0;
  //   _items.forEach((item) {
  //     total = total + item.pickQty;
  //   });

  //   _totalPicked = total;
  //   notifyListeners();
  // }

  
}
