import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class PickItemReceiveProvider with ChangeNotifier {
  List<PickItemReceive> _items;
  PickItemReceive _selected;

  PickItemReceive get selected => _selected;


  List<PickItemReceive> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
        detail.quantity = detail.openQty - detail.pickedQty;
      } else {
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
    final url = '$kBaseUrl/api/getplitemsbyplno/docnum=$pickNumber';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickItemReceive> list = [];
      data.forEach((map) {
        list.add(PickItemReceive.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickItemReceive findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void selectItem(PickItemReceive purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  void addBatchList(
    PickItemReceive pickItemReceive,
    List<PickBatch> batchList,
  ) {
    pickItemReceive.batchList.addAll(batchList);
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void addBin(
    PickItemReceive pickItemReceive,
    PickBatch batchList,
  ) {
    pickItemReceive.batchList.add(batchList);
    notifyListeners();
    print('Added Bin List: $batchList');
  }

  void removeBatchItem(
    PickItemReceive pickItemReceive,
    PickBatch itemBatch,
  ) {
    pickItemReceive.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Item Batch: $itemBatch');
  }

  void inputQtyNonBatch(PickItemReceive pickItemReceive, double qty) {
    print(pickItemReceive);
    pickItemReceive.pickedQty = qty;
    notifyListeners();
    print('Update Qty Non batch: $pickItemReceive');
  }
}
