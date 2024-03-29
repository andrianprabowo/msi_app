import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch_so.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickItemReceiveSoProvider with ChangeNotifier {
  List<PickItemReceiveSo> _items;
  PickItemReceiveSo _selected;

  PickItemReceiveSo get selected => _selected;


  List<PickItemReceiveSo> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
        detail.quantity = detail.openQty - detail.pickedQty;
      }else{
      // calculate remaining qty
         var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
         detail.quantity = detail.openQty - detail.pickedQty;
      }
    });

    // _items = _items.where((item) => item.quantity > 0).toList();

    return _items;
  }

  Future<void> getPlActionByPlNo(String pickNumber) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/getplitemsbysono/docnum=$pickNumber&whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickItemReceiveSo> list = [];
      data.forEach((map) {
        list.add(PickItemReceiveSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickItemReceiveSo findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

   void selectItem(PickItemReceiveSo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  void addBatchList(
    PickItemReceiveSo pickItemReceive,
    List<PickBatchSo> batchList,
  ) {
    pickItemReceive.batchList.addAll(batchList);
    notifyListeners();
    print('Added Batch List: $batchList');
  }

   void addBin(
    PickItemReceiveSo pickItemReceive,
    PickBatchSo batchList,
  ) {
    pickItemReceive.batchList.add(batchList);
    notifyListeners();
    print('Added Bin List: $batchList');
  }

  void removeBatchItem(
    PickItemReceiveSo pickItemReceive,
    PickBatchSo itemBatch,
  ) {
    pickItemReceive.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Item Batch: $itemBatch');
  }

  void inputQtyNonBatch(PickItemReceiveSo pickItemReceive, double qty) {
    pickItemReceive.pickedQty = qty;
    notifyListeners();
    print('Update Qty Non batch: $pickItemReceive');
  }
}
