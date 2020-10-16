import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ItemBinProvider with ChangeNotifier {
  List<ItemBin> _items;

  List<ItemBin> get items {
    _items.forEach((detail) {
      // calculate total batch qty
      var totalBatch = 0.0;
      detail.batchList.forEach((batch) {
        totalBatch = totalBatch + batch.availableQty;
      });
      detail.putQty = totalBatch;

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

  ItemBin findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    ItemBin itemBin,
    List<PutBatch> batchList,
  ) {
    itemBin.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatchItem(
    ItemBin itemBin,
    PutBatch itemBatch,
  ) {
    itemBin.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch Item: $itemBatch');
  }
}
