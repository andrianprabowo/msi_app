import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_put_away.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListPutAwayProvider with ChangeNotifier {
  List<ListPutAway> _items = [];
  ListPutAway _selected;

  List<ListPutAway> get items => _items;
  ListPutAway get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/putaway';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListPutAway> list = [];
      data.forEach((map) {
        list.add(ListPutAway.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListPutAway purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
