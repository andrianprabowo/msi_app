import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PurchaseOrderProvider with ChangeNotifier {
  List<PurchaseOrder> _items = [];

  List<PurchaseOrder> get items => _items;

  Future<void> getAllPoByWarehouseId() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/newgetpobywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PurchaseOrder> list = [];
      data.forEach((map) {
        list.add(PurchaseOrder.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PurchaseOrder findByPoNumber(String poNumber) {
    return _items.firstWhere((element) => element.poNumber == poNumber);
  }
}
