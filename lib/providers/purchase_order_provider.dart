import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseOrderProvider extends ChangeNotifier {
  List<PurchaseOrder> _items;

  List<PurchaseOrder> get items => _items;

  Future<List<PurchaseOrder>> getAllPoByWarehouseId() async {
    final prefs = await SharedPreferences.getInstance();
    final warehouseId = prefs.getString('warehouseId');
    final url = '$kBaseUrl/api/getpodetail/$warehouseId';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      final List<PurchaseOrder> list = [];
      data.forEach((map) {
        list.add(PurchaseOrder.fromMap(map));
      });
      _items = list;
      return _items;
    } catch (error) {
      throw error;
    }
  }
}
