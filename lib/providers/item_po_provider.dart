import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ItemPoProvider extends ChangeNotifier {
  List<ItemPurchaseOrder> _items;

  List<ItemPurchaseOrder> get items => _items;

  Future<void> getPoDetailByDocNum(String docNum) async {
    final url = '$kBaseUrl/api/newgetpodetail/docnum=$docNum';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemPurchaseOrder> list = [];
      data.forEach((map) {
        list.add(ItemPurchaseOrder.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ItemPurchaseOrder findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }
}
