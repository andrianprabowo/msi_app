import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_inv_dispatch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListInvDispatchProvider with ChangeNotifier {
  List<ListInvDispatch> _items = [];
  ListInvDispatch _selected;

  List<ListInvDispatch> get items => _items;
  ListInvDispatch get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/invdispatch';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListInvDispatch> list = [];
      data.forEach((map) {
        list.add(ListInvDispatch.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListInvDispatch purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
