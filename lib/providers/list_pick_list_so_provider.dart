import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_pick_list_soo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListPickListSoProvider with ChangeNotifier {
  List<ListPickListSoo> _items = [];
  ListPickListSoo _selected;

  List<ListPickListSoo> get items => _items;
  ListPickListSoo get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/sopl';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListPickListSoo> list = [];
      data.forEach((map) {
        list.add(ListPickListSoo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListPickListSoo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
