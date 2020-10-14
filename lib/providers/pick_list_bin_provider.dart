import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:http/http.dart' as http;

class PickListBinProvider with ChangeNotifier {
  List<PickListBin> _items = [];
  var _showAllBin = false;

  List<PickListBin> get items {
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
        '$kBaseUrl/api/newgetplbinlist/whscode=$warehouseId&itemcode=$itemCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickListBin> list = [];
      data.forEach((map) {
        list.add(PickListBin.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickListBin findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }
}
