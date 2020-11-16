import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:http/http.dart' as http;

//  List<InventoryDispatchDetailRtv> _items = [];
//   InventoryDispatchDetailRtv _selected;

//   List<InventoryDispatchDetailRtv> get items => _items;
//   InventoryDispatchDetailRtv get selected => _selected;

class PickListBinProvider with ChangeNotifier {
  List<PickListBin> _items = [];
  PickListBin _selected;
  String _recBin;
  var _showAllBin = false;

  List<PickListBin> get items {
    return _showAllBin ? _items : _items.take(5).toList();
  }

  PickListBin get selected => _selected;
  String get recBin => _recBin;

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }

  Future<void> getPlBinList(String itemCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/getplbinlist/whscode=$warehouseId&itemcode=$itemCode';

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
      _recBin = _items.first.binLocation;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickListBin findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }

  void selectbin(PickListBin pickListBin) {
    _selected = pickListBin;
    notifyListeners();
  }
}
