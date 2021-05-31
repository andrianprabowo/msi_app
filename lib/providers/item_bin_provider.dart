import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ItemBinProvider with ChangeNotifier {
  List<ItemBin> _items;
  ItemBin _selected;

  ItemBin get selected => _selected;

  List<ItemBin> get items {
    _items.forEach((detail) {
      // if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.putQty;
        });
        detail.putQty = totalBatch;
        detail.remainingQty = detail.availableQty - detail.putQty;
      // } else {
        // calculate remaining qty
        // var totalBatch = 0.0;
        // detail.batchList.forEach((batch) {
        //   totalBatch = totalBatch + batch.putQty;
        // });
        // detail.putQty = totalBatch;
        // detail.remainingQty = detail.availableQty - detail.putQty;
        // print('sekarang ${detail.putQty}');
        // print('sekarang isi $totalBatch');
      // }
    });

    // _items = _items.where((item) => item.remainingQty > 0).toList();

    return _items;
  }

  Future<void> getItemInStagingBin(String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/newgetiteminstgbin/bincode=$binCode&whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemBin> list = [];
      data.forEach((map) {
        list.add(ItemBin.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
  void selectItem(ItemBin purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  ItemBin findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

// void addBatchList(
//     PickItemReceive pickItemReceive,
//     List<PickBatch> batchList,
//   ) {
//     pickItemReceive.batchList.addAll(batchList);
//     notifyListeners();
//     print('Added Batch List: $batchList');
//   }

  void addBatchList(
    ItemBin itemBin,
    List<PutBatch> batchList,
  ) {
    itemBin.batchList.addAll(batchList);
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void addBin(
    ItemBin item,
    PutBatch batchList,
  ) {
    item.batchList.add(batchList);
    notifyListeners();
    print('N Added Bin List: $batchList');
  }

  void removeBatchItem(
    ItemBin itemBin,
    PutBatch itemBatch,
  ) {
    itemBin.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch Item: $itemBatch');
  }

  void inputQtyNonBatch(ItemBin itemBin, double qty) {
    itemBin.putQty = qty;
    notifyListeners();
    print('Update Qty Non batch: $itemBin');
  }
}
