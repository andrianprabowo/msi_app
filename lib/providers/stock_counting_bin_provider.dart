import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';

class StockCountingBinProvider with ChangeNotifier {
  List<StockCountingBin> _items = [];
  var _showAllBin = false;

  List<StockCountingBin> get items {
    return _showAllBin ? _items : _items.take(5).toList();
  }

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }

  Future<void> getPlBinList(String itemCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/getstcbin/whscode=$warehouseId&itemcode=$itemCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StockCountingBin> list = [];
      data.forEach((map) {
        list.add(StockCountingBin.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StockCountingBin findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }
}
