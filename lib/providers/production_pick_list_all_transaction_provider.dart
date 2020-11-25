import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_all_transaction_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionPickListAllTransactionProvider with ChangeNotifier {
  List<ProductionPickListAllTransactionModel> _items = [];
  ProductionPickListAllTransactionModel _selected;

  List<ProductionPickListAllTransactionModel> get items => _items;
  ProductionPickListAllTransactionModel get selected => _selected;

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/plrm';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionPickListAllTransactionModel> list = [];
      data.forEach((map) {
        list.add(ProductionPickListAllTransactionModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
