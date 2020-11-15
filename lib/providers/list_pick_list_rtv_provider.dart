import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_pick_list_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListPickListRtvProvider with ChangeNotifier {
  List<ListPickListRtv> _items = [];
  ListPickListRtv _selected;

  List<ListPickListRtv> get items => _items;
  ListPickListRtv get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/rvpl';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListPickListRtv> list = [];
      data.forEach((map) {
        list.add(ListPickListRtv.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListPickListRtv purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
