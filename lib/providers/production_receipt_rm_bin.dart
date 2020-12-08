import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionReceiptRMBinProvider with ChangeNotifier {
   List<ProductionReceiptRmBin> _items = [];
  ProductionReceiptRmBin _selected;
  String _recBin;
  var _showAllBin = false;

  List<ProductionReceiptRmBin> get items {
    return _showAllBin ? _items : _items.take(5).toList();
  }

  ProductionReceiptRmBin get selected => _selected;
  String get recBin => _recBin;

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }

  Future<void> getPlBinList(String cardCode) async {
    // final warehouseId = await Prefs.getString(Prefs.warehouseId);
    
    final url =
        '$kBaseUrl/api/PAgetplbinlist/whscode=$cardCode';
        

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptRmBin> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptRmBin.fromMap(map));
      });

      _items = list;
      _recBin = _items.first.binLocation;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionReceiptRmBin findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }

  void selectbin(ProductionReceiptRmBin pickListBin) {
    _selected = pickListBin;
    notifyListeners();
  }
}