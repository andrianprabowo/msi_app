import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';

class StockCountingBatchProvider with ChangeNotifier {
  List<StockCountingBatch> _items = [];
  double _totalPicked = 0.0;

  List<StockCountingBatch> get items {
    // return _items.where((item) => item.availableQty > item.pickQty).toList();
    return _items;
  }

  List<StockCountingBatch> get pickedItems {
    return _items;
    // return _items.where((item) => item.pickQty > 0).toList();
  }

  double get totalPicked => _totalPicked;

  Future<void> getPlBatchByItemWhs(
      BuildContext context, String itemCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final header =
        Provider.of<StockCountingBinProvider>(context, listen: false).selected;
    final binLoc = header.binLocation;
    final url =
        '$kBaseUrl/api/getstcbatch/itemcode=$itemCode&whscode=$warehouseId&bincode=$binLoc';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StockCountingBatch> list = [];
      data.forEach((map) {
        list.add(StockCountingBatch.fromMap(map));
      });

      _items = list;

      countTotal();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StockCountingBatch findByBatchNo(String batchNo) {
    return _items.firstWhere((item) => item.batchNo == batchNo);
  }

  void updatePickQty(String batchNo, double pickQty) {
    StockCountingBatch item =
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

  void addItemBatch(StockCountingBatch itemBatch) {
    _items.add(itemBatch);
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void removeBatch(StockCountingBatch itemBatch) {
    _items.remove(itemBatch);
    notifyListeners();
    print('Removed Batch: $itemBatch');
  }
}
