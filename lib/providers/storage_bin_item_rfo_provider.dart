import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/storage_bin_item_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:http/http.dart' as http;

class StorageBinItemRfoProvider with ChangeNotifier {
  List<StorageBinItemRfo> _items = [];
  String _recBin;
  var _showAllBin = false;

  List<StorageBinItemRfo> get items {
    return _showAllBin ? _items : _items.take(2).toList();
  }

  String get recBin => _recBin;

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }

  Future<void> getBinLocList(String itemCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    // final url = '$kBaseUrl/api/getbinlocnonstg/$warehouseId';
    final url =
        '$kBaseUrl/api/newGetbinlocnonstg/whscode=$warehouseId&itemcode=$itemCode';
    print('itemcode adalah $itemCode');

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StorageBinItemRfo> list = [];
      data.forEach((map) {
        list.add(StorageBinItemRfo.fromMap(map));
      });

      _items = list;
      _recBin = _items.first.binCode;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StorageBinItemRfo findBinByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }
}
