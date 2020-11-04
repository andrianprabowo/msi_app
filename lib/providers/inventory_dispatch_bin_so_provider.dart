import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_bin_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:http/http.dart' as http;

class InventoryDispatchBinSoProvider with ChangeNotifier {
  List<InventoryDispatchBinSo> _items = [];
  var _showAllBin = false;

  List<InventoryDispatchBinSo> get items {
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
        '$kBaseUrl/api/getcontainerbin/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<InventoryDispatchBinSo> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchBinSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchBinSo findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }
}
