import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header_so.dart';

import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class InventoryDispatchHeaderSoProvider with ChangeNotifier {
  List<InventoryDispatchHeaderSo> _items;
  InventoryDispatchHeaderSo _selected;

  List<InventoryDispatchHeaderSo> get items => _items;
  InventoryDispatchHeaderSo get selected => _selected;

  // List<InventoryDispatchDetail> get itemBinList {
  //   // return _selected.itemDispatchDetail.where((item) => item. > 0).toList();
  // }

  Future<void> getBinLoc() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/invGetplbinlist/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<InventoryDispatchHeaderSo> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchHeaderSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchHeaderSo findByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }

  void selectStagingBin(InventoryDispatchHeaderSo inventoryDispatchHeader) {
    _selected = inventoryDispatchHeader;
    notifyListeners();
  }

  
}
