import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ItemPoProvider extends ChangeNotifier {
  List<ItemPurchaseOrder> _items;

  List<ItemPurchaseOrder> get items => _items;

  Future<List<ItemPurchaseOrder>> getPoDetailByDocNum(String docNum) async {
    final url = '$kBaseUrl/api/po/$docNum';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      final List<ItemPurchaseOrder> list = [];
      data.forEach((map) {
        list.add(ItemPurchaseOrder.fromMap(map));
      });
      _items = list;
      return _items;
    } catch (error) {
      throw error;
    }
  }
}
