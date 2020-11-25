import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_number_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ProductionIssueNumberProvider with ChangeNotifier {
  List<ProductionIssueNumberModel> _items;
  ProductionIssueNumberModel _selected;

  List<ProductionIssueNumberModel> get items => _items;
  ProductionIssueNumberModel get selected => _selected;

  Future<void> getTransactionNumber(String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getipbywhs/whscode=$warehouseId&bincode=$binCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionIssueNumberModel> list = [];
      data.forEach((map) {
        list.add(ProductionIssueNumberModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  } 

  ProductionIssueNumberModel findByPickNumber(String pickNumber) {
    return _items.firstWhere((element) => element.pickNumber == pickNumber);
  }

  void selectPickList(ProductionIssueNumberModel productionIssueNumberModel) {
    _selected = productionIssueNumberModel;
    notifyListeners();
  }
}
