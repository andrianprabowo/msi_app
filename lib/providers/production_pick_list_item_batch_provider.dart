import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ProductionPickListItemBatchProvider with ChangeNotifier {
  List<ProductionPickListItemBatchModel> _items = [];
  double _totalPicked = 0.0;
  //
  var _showAllItem = false;

  bool get showAllItem => _showAllItem;

  void toggleStatus() {
    _showAllItem = !_showAllItem;
    notifyListeners();
  }

  //
  int _show = 1;
//
  List<ProductionPickListItemBatchModel> get items {
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

    // return _items.where((item) => item.availableQty > item.pickQty).toList();
  }

  List<ProductionPickListItemBatchModel> get pickedItems {
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

      final List<ProductionPickListItemBatchModel> list = [];
      data.forEach((map) {
        list.add(ProductionPickListItemBatchModel.fromMap(map));
      });

      _items = list;

      countTotal();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionPickListItemBatchModel findByBatchNo(String batchNo) {
    return _items.firstWhere((item) => item.batchNo == batchNo);
  }

  void updatePickQty(String batchNo, double pickQty) {
    ProductionPickListItemBatchModel item =
        _items.where((item) => item.batchNo == batchNo).first;
    if (item != null) {
      item.pickQty = pickQty;
    }

    countTotal();
    notifyListeners();
  }

  void clear() {
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
}
