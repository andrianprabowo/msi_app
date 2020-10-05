import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ItemBatchProvider with ChangeNotifier {
  List<ItemBatch> _items;

  List<ItemBatch> get items => _items;

  Future<void> getBatchListByItemWarehouse(
    String itemCode,
    String binCode,
  ) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    // final url = '$kBaseUrl/api/getplbatchlistbyitmwhs/itemcode=$itemCode&whscode=$warehouseId&bincode=$binCode';
    final url =
        '$kBaseUrl/api/getplbatchlistbyitmwhs/itemcode=FDG0184-B1&whscode=WMSISTPR&bincode=WMSISTPR-SYSTEM-BIN-LOCATION';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ItemBatch> list = [];
      data.forEach((map) {
        list.add(ItemBatch.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ItemBatch findBy(String code) {
    return _items.firstWhere((element) => element.batchNo == code);
  }
}
