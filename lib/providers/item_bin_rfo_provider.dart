import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_rfo.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ItemBinRfoProvider with ChangeNotifier {
  List<ItemBinRfo> _items;

  List<ItemBinRfo> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.putQty;
        });
        detail.putQty = totalBatch;
      }

      // calculate remaining qty
      detail.remainingQty = detail.availableQty - detail.putQty;
    });

    // _items = _items.where((item) => item.remainingQty > 0).toList();

    return _items;
  }

  Future<void> getItemInStagingBin(String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url =
        '$kBaseUrl/api/getiteminstgbin/bincode=$binCode&whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemBinRfo> list = [];
      data.forEach((map) {
        list.add(ItemBinRfo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ItemBinRfo findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    ItemBinRfo itemBin,
    List<PutBatchRfo> batchList,
  ) {
    itemBin.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatchItem(
    ItemBinRfo itemBin,
    PutBatchRfo itemBatch,
  ) {
    itemBin.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch Item: $itemBatch');
  }

  void inputQtyNonBatch(ItemBinRfo itemBin, double qty) {
    itemBin.putQty = qty;
    notifyListeners();
    print('Update Qty Non batch: $itemBin');
  }
}
