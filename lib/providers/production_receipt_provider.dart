import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/models/production_receipt_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ProductionReceiptProvider with ChangeNotifier {
  List<ProductionReceiptModel> _items = [];
  ProductionReceiptModel _selected;

  List<ProductionReceiptModel> get items => _items;
  ProductionReceiptModel get selected => _selected;

  List<ProductionReceiptItemModel> get detailList {
    return _selected.detailList.where((item) => item.quantity > 0).toList();
  }

  Future<void> getAllPoByWarehouseId() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getwobywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptModel> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionReceiptModel findByPoNumber(String poNumber) {
    return _items.firstWhere((element) => element.poNumber == poNumber);
  }

  void selectPo(ProductionReceiptModel purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  void setStagingBin(String stagingBin) {
    _selected.storageLocation = stagingBin;
    notifyListeners();
  }

  void setGlItem(String gl) {
    _selected.itemGl = gl;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createProductionReceipt() async {
    // var url = '$kBaseUrl/tgrpo/tgrpo/api/ListGRPOFG';
    var url = '$kBaseUrl/tgrpo/tgrpo/api/MultiPutAwayFromOutlet';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final binId = await Prefs.getString(Prefs.binId);
    final binGl = await Prefs.getString(Prefs.binGl);
    final whsCode = await Prefs.getString(Prefs.warehouseId);
    final whsName = await Prefs.getString(Prefs.warehouseName);

    _selected.storageLocation = binId;
    _selected.vendorCode = whsCode;
    _selected.vendorName = whsName;
    _selected.detailList = detailList;
    _selected.itemGl = binGl;

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
