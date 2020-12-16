import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/models/purchase_order_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PurchaseOrderRfoProvider with ChangeNotifier {
  List<PurchaseOrderRfo> _items = [];
  PurchaseOrderRfo _selected;

  List<PurchaseOrderRfo> get items => _items;
  PurchaseOrderRfo get selected => _selected;

  List<ItemPurchaseOrderRfo> get detailList {
    return _selected.detailList.where((item) => item.quantity > 0).toList();
  }

  Future<void> getAllPoByWarehouseId() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getrtobywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PurchaseOrderRfo> list = [];
      data.forEach((map) {
        list.add(PurchaseOrderRfo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PurchaseOrderRfo findByPoNumber(String poNumber) {
    return _items.firstWhere((element) => element.poNumber == poNumber);
  }

  void selectPo(PurchaseOrderRfo purchaseOrder) {
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
    _selected.detailList = detailList;

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: _selected.toJson(),
      );
      print(response.request);
      print(_selected.toJson());

      print('Status: ${_selected.userId}');
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
