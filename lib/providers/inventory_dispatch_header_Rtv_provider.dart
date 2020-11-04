import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header_rtv.dart';

import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class InventoryDispatchHeaderRtvProvider with ChangeNotifier {
  List<InventoryDispatchHeaderRtv> _items;
  InventoryDispatchHeaderRtv _selected;

  List<InventoryDispatchHeaderRtv> get items => _items;
  InventoryDispatchHeaderRtv get selected => _selected;

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

      final List<InventoryDispatchHeaderRtv> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchHeaderRtv.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchHeaderRtv findByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }

  void selectStagingBin(InventoryDispatchHeaderRtv inventoryDispatchHeader) {
    _selected = inventoryDispatchHeader;
    notifyListeners();
  }

  
}
