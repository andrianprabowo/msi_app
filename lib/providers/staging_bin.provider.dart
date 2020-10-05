import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/staging_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class StagingBinProvider with ChangeNotifier {
  List<StagingBin> _items;

  List<StagingBin> get items => _items;

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

  StagingBin findBy(String code) {
    return _items.firstWhere((element) => element.binCode == code);
  }
}
