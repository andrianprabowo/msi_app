import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PurchaseOrderProvider with ChangeNotifier {
  List<PurchaseOrder> _items = [];
  PurchaseOrder _selected;

  List<PurchaseOrder> get items => _items;
  PurchaseOrder get selected => _selected;

  List<ItemPurchaseOrder> get detailList {
    return _selected.detailList.where((item) => item.quantity > 0).toList();
  }

  Future<void> getAllPoByWarehouseId() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/newgetpobywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PurchaseOrder> list = [];
      data.forEach((map) {
        list.add(PurchaseOrder.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PurchaseOrder findByPoNumber(String poNumber) {
    return _items.firstWhere((element) => element.poNumber == poNumber);
  }

  void selectPo(PurchaseOrder purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  void setStagingBin(String stagingBin) {
    _selected.storageLocation = stagingBin;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createReceiptVendor() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listtgrpoes';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    _selected.detailList = detailList;

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
