import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_po_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ItemPoBatchProvider extends ChangeNotifier {
  List<ItemPoBatch> _items;

  List<ItemPoBatch> get items => _items;

  Future<void> getPoDetailByDocNumAndItemCode(
      String docNum, String itemCode) async {
    final url =
        '$kBaseUrl/api/newgetpobydocitem/docnum=$docNum&itemcode=$itemCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemPoBatch> list = [];
      data.forEach((map) {
        list.add(ItemPoBatch.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ItemPoBatch findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }
}
