import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_all_transaction_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionIssueAllTransactionProvider with ChangeNotifier {
  List<ProductionIssueAllTransactionModel> _items = [];
  ProductionIssueAllTransactionModel _selected;

  List<ProductionIssueAllTransactionModel> get items => _items;
  ProductionIssueAllTransactionModel get selected => _selected;

  Future<void> getAllData() async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/IssueRm';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionIssueAllTransactionModel> list = [];
      data.forEach((map) {
        list.add(ProductionIssueAllTransactionModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void selectPo(ProductionIssueAllTransactionModel purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }
}
