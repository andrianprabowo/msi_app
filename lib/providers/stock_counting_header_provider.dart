import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_header.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class StockCountingHeaderProvider with ChangeNotifier {
  List<StockCountingHeader> _items = [];
  StockCountingHeader _selected;

  List<StockCountingHeader> get items => _items;
  StockCountingHeader get selected => _selected;

  // List<ItemStockCountingHeader> get detailList {
  //   return _selected.detailList.where((item) => item.quantity > 0).toList();
  // }

  Future<void> getAllPoByWarehouseId() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getstcbywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StockCountingHeader> list = [];
      data.forEach((map) {
        list.add(StockCountingHeader.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StockCountingHeader findByPoNumber(String poNumber) {
    return _items.firstWhere((element) => element.poNumber == poNumber);
  }

  void selectPo(StockCountingHeader purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  void setStagingBin(String stagingBin) {
    _selected.storageLocation = stagingBin;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createReceiptVendor() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/ListReceiptRFO';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final binId = await Prefs.getString(Prefs.binId);

    _selected.storageLocation = binId;
    _selected.plant = warehouseId;
    // _selected.detailList = detailList;

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
