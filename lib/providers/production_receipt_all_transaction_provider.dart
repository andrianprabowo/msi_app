import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_all_transaction_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionReceiptAllTransactionProvider with ChangeNotifier {
  List<ProductionReceiptAllTransactionModel> _items = [];
  ProductionReceiptAllTransactionModel _selected;

  List<ProductionReceiptAllTransactionModel> get items => _items;
  ProductionReceiptAllTransactionModel get selected => _selected;

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/receiptfg';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptAllTransactionModel> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptAllTransactionModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

   void selectPo(ProductionReceiptAllTransactionModel purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

}
