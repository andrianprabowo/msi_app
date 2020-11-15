import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_good_receipt_po_outlet.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListGrpoOutletProvider with ChangeNotifier {
  List<ListGoodReceiptPoOutlet> _items = [];
  ListGoodReceiptPoOutlet _selected;

  List<ListGoodReceiptPoOutlet> get items => _items;
  ListGoodReceiptPoOutlet get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/scrptoutlet';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListGoodReceiptPoOutlet> list = [];
      data.forEach((map) {
        list.add(ListGoodReceiptPoOutlet.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListGoodReceiptPoOutlet purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
