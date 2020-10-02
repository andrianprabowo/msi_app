import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickListWhsProvider extends ChangeNotifier {
  List<PickListWhs> _items;

  List<PickListWhs> get items => _items;

  Future<List<PickListWhs>> getPlDetailByWhs() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getplbywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      final List<PickListWhs> list = [];
      data.forEach((map) {
        list.add(PickListWhs.fromMap(map));
      });
      _items = list;
      return _items;
    } catch (error) {
      throw error;
    }
  }
}
