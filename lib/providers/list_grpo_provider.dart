import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_good_receipt_po.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListGrpoProvider with ChangeNotifier {
  List<ListGoodReceiptPo> _items = [];
  ListGoodReceiptPo _selected;

  List<ListGoodReceiptPo> get items => _items;
  ListGoodReceiptPo get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/grpo';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListGoodReceiptPo> list = [];
      data.forEach((map) {
        list.add(ListGoodReceiptPo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListGoodReceiptPo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
