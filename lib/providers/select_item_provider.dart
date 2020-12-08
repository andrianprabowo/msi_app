import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/utils/constants.dart';
class SelectItemProvider extends ChangeNotifier {
  List<StockCountingItem> _itemsBin;
  String binIdRtv;


  List<StockCountingItem> get itemsBins => _itemsBin;

  Future<void> getAllBinRtv() async {

    final url = '$kBaseUrl/api/getallitem';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;

      final List<StockCountingItem> list = [];
      data.forEach((map) {
        list.add(StockCountingItem.fromMap(map));
      });

      _itemsBin = list;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
