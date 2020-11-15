import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_stck_count.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListStckCountProvider with ChangeNotifier {
  List<ListStckCount> _items = [];
  ListStckCount _selected;

  List<ListStckCount> get items => _items;
  ListStckCount get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/stckcnting';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListStckCount> list = [];
      data.forEach((map) {
        list.add(ListStckCount.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListStckCount purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
