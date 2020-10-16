import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/storage_bin_item.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:http/http.dart' as http;

class StorageBinItemProvider with ChangeNotifier {
  List<StorageBinItem> _items = [];
  var _showAllBin = false;

  List<StorageBinItem> get items {
    return _showAllBin ? _items : _items.take(2).toList();
  }

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }

  Future<void> getBinLocList() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getbinlocnonstg/$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StorageBinItem> list = [];
      data.forEach((map) {
        list.add(StorageBinItem.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StorageBinItem findBinByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }
}
