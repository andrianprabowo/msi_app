import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header.dart';

import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class InventoryDispatchHeaderProvider with ChangeNotifier {
  List<InventoryDispatchHeader> _items;
  InventoryDispatchHeader _selected;

  List<InventoryDispatchHeader> get items => _items;
  InventoryDispatchHeader get selected => _selected;

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

      final List<InventoryDispatchHeader> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchHeader.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchHeader findByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }

  void selectStagingBin(InventoryDispatchHeader inventoryDispatchHeader) {
    _selected = inventoryDispatchHeader;
    notifyListeners();
  }

  
}
