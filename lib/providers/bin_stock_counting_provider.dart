import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';

class BinStockCountingProvider with ChangeNotifier {
  List<StockCountingBin> _itemsBinList;
  StockCountingBin _selected;

  // String binIdRtv;

  List<StockCountingBin> get itemsBins => _itemsBinList;
  StockCountingBin get selected => _selected;

  Future<void> getAllBinRtv() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    print("hjhjh");
    final url = '$kBaseUrl/api/getstcbin/whscode=$warehouseId';
    print("hjhjh$url");

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;

      final List<StockCountingBin> list = [];
      data.forEach((map) {
        list.add(StockCountingBin.fromMap(map));
      });
      _itemsBinList = list;
      notifyListeners();
    } catch (error) {
      print('errror disini');

      throw error;
    }
  }

  StockCountingBin findByBinCode(String binCode) {
    return _itemsBinList.firstWhere((element) => element.binCode == binCode);
  }

  void selectStagingBin(StockCountingBin stagingBin) {
    _selected = stagingBin;
    notifyListeners();
  }
}
