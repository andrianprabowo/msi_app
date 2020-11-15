import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_inv_dispatch_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListInvDispatchRtvProvider with ChangeNotifier {
  List<ListInvDispatchRtv> _items = [];
  ListInvDispatchRtv _selected;

  List<ListInvDispatchRtv> get items => _items;
  ListInvDispatchRtv get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/rvidp';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListInvDispatchRtv> list = [];
      data.forEach((map) {
        list.add(ListInvDispatchRtv.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListInvDispatchRtv purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
