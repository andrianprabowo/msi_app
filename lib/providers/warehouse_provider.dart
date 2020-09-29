import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/utils/constants.dart';

class WarehouseProvider extends ChangeNotifier {
  List<Warehouse> _items;

  List<Warehouse> get items => _items;

  Future<void> getAllWarehouse() async {
    final url = '$kBaseUrl/api/owhs';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;

      final List<Warehouse> list = [];
      data.forEach((map) {
        list.add(Warehouse.fromMap(map));
      });
      _items = list;
    } catch (error) {
      throw error;
    }
  }
}
