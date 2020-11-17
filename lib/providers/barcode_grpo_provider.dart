import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/barcode_grpo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class BarcodeGrpoProvider with ChangeNotifier {
  List<BarcodeGrpo> _items = [];
  BarcodeGrpo _selected;

  List<BarcodeGrpo> get items => _items;
  BarcodeGrpo get selected => _selected;

  

  Future<void> getAllData() async {
    // final url = '$kBaseUrl/api/grpobarcode/docnum=MS2020100000001';
    final url = '$kBaseUrl/api/grpobarcode/docnum=MS2020110000003';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<BarcodeGrpo> list = [];
      data.forEach((map) {
        list.add(BarcodeGrpo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  
  void selectPo(BarcodeGrpo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }



  
}
