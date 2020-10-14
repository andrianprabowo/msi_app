import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickListWhsProvider with ChangeNotifier {
  List<PickListWhs> _items = [];
  PickListWhs _selected;

  List<PickListWhs> get items => _items;
  PickListWhs get selected => _selected;

  Future<void> getPlByWarehouse() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getplbywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickListWhs> list = [];
      data.forEach((map) {
        list.add(PickListWhs.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickListWhs findByPickNumber(String pickNumber) {
    return _items.firstWhere((element) => element.pickNumber == pickNumber);
  }

  void selectPickList(PickListWhs pickListWhs) {
    _selected = pickListWhs;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createPickList() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listgrpodlvs';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: _selected.toJson(),
      );
      print(response.request);

      print('Status: ${response.statusCode}');
      final data = json.decode(response.body) as Map;
      print(data);
      return data;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
