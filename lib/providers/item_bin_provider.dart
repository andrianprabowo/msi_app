import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ItemBinProvider with ChangeNotifier {
  List<ItemBin> _items;

  List<ItemBin> get items => _items;

  Future<void> getItemInStagingBin(String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    // final url = '$kBaseUrl/api/getiteminstgbin/bincode=$binCode&whscode=$warehouseId';
    final url =
        '$kBaseUrl/api/getiteminstgbin/bincode=WMSISTPR-SYSTEM-BIN-LOCATION&whscode=WMSISTPR';

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

  ItemBin findBy(String code) {
    return _items.firstWhere((element) => element.itemCode == code);
  }
}
