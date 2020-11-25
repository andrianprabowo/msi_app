import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch_rtv.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickItemReceiveRtvProvider with ChangeNotifier {
  List<PickItemReceiveRtv> _items;

  List<PickItemReceiveRtv> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
      }
      // calculate remaining qty
      detail.quantity = detail.openQty - detail.pickedQty;
    });

    // _items = _items.where((item) => item.quantity > 0).toList();

    return _items;
  }

  Future<void> getPlActionByPlNo(String pickNumber) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getplitemsbyrvno/docnum=$pickNumber&whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickItemReceiveRtv> list = [];
      data.forEach((map) {
        list.add(PickItemReceiveRtv.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickItemReceiveRtv findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    PickItemReceiveRtv pickItemReceive,
    List<PickBatchRtv> batchList,
  ) {
    pickItemReceive.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatchItem(
    PickItemReceiveRtv pickItemReceive,
    PickBatchRtv itemBatch,
  ) {
    pickItemReceive.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Item Batch: $itemBatch');
  }

  void inputQtyNonBatch(PickItemReceiveRtv pickItemReceive, double qty) {
    pickItemReceive.pickedQty = qty;
    notifyListeners();
    print('Update Qty Non batch: $pickItemReceive');
  }
}
