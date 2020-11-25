import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/models/production_issue_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ProductionIssueProvider with ChangeNotifier {
  List<ProductionIssueModel> _items;
  ProductionIssueModel _selected;

  List<ProductionIssueModel> get items => _items;
  ProductionIssueModel get selected => _selected;

  List<ProductionIssueItemModel> get itemBinList {
    return _selected.itemBinList.where((item) => item.putQty > 0).toList();
  }

  Future<void> getBinLoc() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getplbinlistIssueRawMaterial/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionIssueModel> list = [];
      data.forEach((map) {
        list.add(ProductionIssueModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionIssueModel findByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }

  void selectProductionIssueModel(ProductionIssueModel productionIssueModel) {
    _selected = productionIssueModel;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createProductionIssue() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listissuerm';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    
    _selected.itemBinList = itemBinList;

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: _selected.toJson(),
      );
      print(response.request);
      print(_selected.toJson());

      print('Status: ${response.statusCode}');
      final data = json.decode(response.body) as Map;
      print(data);
      return data;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
