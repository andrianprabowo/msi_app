import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_all_transaction_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionReceiptRMAllTransactionProvider with ChangeNotifier {
  List<ProductionReceiptRMAllTransactionModel> _items = [];
  ProductionReceiptRMAllTransactionModel _selected;

  List<ProductionReceiptRMAllTransactionModel> get items => _items;
  ProductionReceiptRMAllTransactionModel get selected => _selected;

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/srcptrm';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptRMAllTransactionModel> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptRMAllTransactionModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
