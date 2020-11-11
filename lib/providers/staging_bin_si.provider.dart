import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_si.dart';
import 'package:msi_app/models/staging_bin_si.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class StagingBinSiProvider with ChangeNotifier {
  List<StagingBinSi> _items;
  StagingBinSi _selected;

  List<StagingBinSi> get items => _items;
  StagingBinSi get selected => _selected;

  List<ItemBinSi> get itemBinList {
    return _selected.itemBinList.where((item) => item.putQty > 0).toList();
  }

  Future<void> getBinLoc() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getbinloc/$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StagingBinSi> list = [];
      data.forEach((map) {
        list.add(StagingBinSi.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StagingBinSi findByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }

  void selectStagingBin(StagingBinSi stagingBin) {
    _selected = stagingBin;
    notifyListeners();
  }

  // Future<Map<String, dynamic>> createPutAway() async {
  //   var url = '$kBaseUrl/tgrpo/tgrpo/api/listputawayrfo';
  //   final headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //   };

  //   final warehouseId = await Prefs.getString(Prefs.warehouseId);
  //   final warehouseName = await Prefs.getString(Prefs.warehouseName);

  //   _selected.plant = warehouseId;
  //   _selected.plantName = warehouseName;
  //   _selected.itemBinList = itemBinList;

  //   try {
  //     var response = await http.post(
  //       url,
  //       headers: headers,
  //       body: _selected.toJson(),
  //     );
  //     print(response.request);
  //     print(_selected.toJson());

  //     print('Status: ${response.statusCode}');
  //     final data = json.decode(response.body) as Map;
  //     print(data);
  //     return data;
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }
}
