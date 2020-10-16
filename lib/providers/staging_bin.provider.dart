import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/staging_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class StagingBinProvider with ChangeNotifier {
  List<StagingBin> _items;
  StagingBin _selected;

  List<StagingBin> get items => _items;
  StagingBin get selected => _selected;

  List<ItemBin> get itemBinList {
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

      final List<StagingBin> list = [];
      data.forEach((map) {
        list.add(StagingBin.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StagingBin findByBinCode(String binCode) {
    return _items.firstWhere((element) => element.binCode == binCode);
  }

  void selectStagingBin(StagingBin stagingBin) {
    _selected = stagingBin;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createPutAway() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listgrpodlvs';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    _selected.itemBinList = itemBinList;

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: _selected.toJson(),
      );
      print(response.request);
      print(_selected.toJson());

      print('Status: ${response.statusCode}');
      final data = json.decode(response.body) as Map;
      print(data);
      return data;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
