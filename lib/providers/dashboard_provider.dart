import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/barcode_grpo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class DashboardProvider with ChangeNotifier {
  List<Dashboard> _items = [];
  Dashboard _selected;

  List<Dashboard> get items => _items;
  Dashboard get selected => _selected;

  

  Future<void> getAllData() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/dashboard/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<Dashboard> list = [];
      data.forEach((map) {
        list.add(Dashboard.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(Dashboard purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
