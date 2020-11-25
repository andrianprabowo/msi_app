import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_bin_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:http/http.dart' as http;

class ProductionPickListBinProvider with ChangeNotifier {
  List<ProductionPickListBinModel> _items = [];
  String _recBin;
  var _showAllBin = false;

  List<ProductionPickListBinModel> get items {
    return _showAllBin ? _items : _items.take(5).toList();
  }

  String get recBin => _recBin;

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

      final List<ProductionPickListBinModel> list = [];
      data.forEach((map) {
        list.add(ProductionPickListBinModel.fromMap(map));
      });

      _items = list;
      _recBin = _items.first.binLocation;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionPickListBinModel findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }
}
