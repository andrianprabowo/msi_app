import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_bin_list_model.dart';

import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ProductionReceiptRMProvider with ChangeNotifier {
  List<ProductionReceiptRMBinListModel> _items;
  ProductionReceiptRMBinListModel _selected;

  List<ProductionReceiptRMBinListModel> get items => _items;
  ProductionReceiptRMBinListModel get selected => _selected;

  // List<InventoryDispatchDetail> get itemBinList {
  //   // return _selected.itemDispatchDetail.where((item) => item. > 0).toList();
  // }

  Future<void> getBinLoc() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getplbinlistpa/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptRMBinListModel> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptRMBinListModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionReceiptRMBinListModel findByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }

  void selectStagingBin(ProductionReceiptRMBinListModel inventoryDispatchHeader) {
    _selected = inventoryDispatchHeader;
    notifyListeners();
  }
}
