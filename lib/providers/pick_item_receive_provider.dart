import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class PickItemReceiveProvider with ChangeNotifier {
  List<PickItemReceive> _items;

  List<PickItemReceive> get items => _items;

  Future<void> getPlActionByPlNo(String pickNumber) async {
    final url = '$kBaseUrl/api/getplitemsbyplno/docnum=$pickNumber';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickItemReceive> list = [];
      data.forEach((map) {
        list.add(PickItemReceive.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickItemReceive findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }
}
