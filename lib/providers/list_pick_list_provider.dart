import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_pick_list.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListPickListProvider with ChangeNotifier {
  List<ListPickList> _items = [];
  ListPickList _selected;

  List<ListPickList> get items => _items;
  ListPickList get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/picklist';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListPickList> list = [];
      data.forEach((map) {
        list.add(ListPickList.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListPickList purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
