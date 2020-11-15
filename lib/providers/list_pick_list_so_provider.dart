import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_pick_list_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListPickListSoProvider with ChangeNotifier {
  List<ListPickListSo> _items = [];
  ListPickListSo _selected;

  List<ListPickListSo> get items => _items;
  ListPickListSo get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/sopl';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListPickListSo> list = [];
      data.forEach((map) {
        list.add(ListPickListSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListPickListSo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
