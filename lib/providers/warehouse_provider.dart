import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';

class WarehouseProvider with ChangeNotifier {
  List<Warehouse> _items;

  List<Warehouse> get items => _items;

  Future<void> getWarehouseByUsername() async {
    final username = await Prefs.getString(Prefs.username);
    final url = '$kBaseUrl/tgrpo/tgrpo/api/getlistwarehouse/username=$username';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      if (data == null) return;

      final List<Warehouse> list = [];
      data.forEach((map) {
        list.add(Warehouse.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
