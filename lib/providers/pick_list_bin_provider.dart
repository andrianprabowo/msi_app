import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:http/http.dart' as http;

class PickListBinProvider with ChangeNotifier {
  List<PickListBin> _items = [];
  var _showAllBin = false;

  List<PickListBin> get items {
    // _items.forEach((detail) {
    //   // calculate total batch qty
    //   var totalBatch = 0.0;
    //   detail.batchList.forEach((batch) {
    //     totalBatch = totalBatch + batch.availableQty;
    //   });
    //   detail.quantity = totalBatch;

    //   // calculate remaining qty
    //   detail.remainingQty = detail.openQty - detail.quantity;
    // });

    // _items = _items.where((item) => item.remainingQty > 0).toList();

    return _items;
  }

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }

  Future<void> getPlBinList() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getplbinlist/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickListBin> list = [];
      data.forEach((map) {
        list.add(PickListBin.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickListBin findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }

  // void addBatch(ItemPurchaseOrder itemPo, ItemBatch itemBatch) {
  //   itemPo.batchList.add(itemBatch);
  //   notifyListeners();
  //   print('Added Batch: $itemBatch');
  // }

  // void removeBatch(ItemPurchaseOrder itemPo, ItemBatch itemBatch) {
  //   itemPo.batchList.remove(itemBatch);
  //   notifyListeners();
  //   print('Removed Batch: $itemBatch');
  // }
}
