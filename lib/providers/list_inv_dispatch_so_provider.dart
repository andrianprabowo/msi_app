import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_inv_dispatch_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListInvDispatchSoProvider with ChangeNotifier {
  List<ListInvDispatchSo> _items = [];
  ListInvDispatchSo _selected;

  List<ListInvDispatchSo> get items => _items;
  ListInvDispatchSo get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/soidp';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListInvDispatchSo> list = [];
      data.forEach((map) {
        list.add(ListInvDispatchSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListInvDispatchSo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
