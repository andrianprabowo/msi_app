import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_put_away_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListPutAwayRfoProvider with ChangeNotifier {
  List<ListPutAwayRfo> _items = [];
  ListPutAwayRfo _selected;

  List<ListPutAwayRfo> get items => _items;
  ListPutAwayRfo get selected => _selected;

  

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/pwyrcptoutlet';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ListPutAwayRfo> list = [];
      data.forEach((map) {
        list.add(ListPutAwayRfo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(ListPutAwayRfo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
