import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/bin.rfv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';

class BinRtvProvider extends ChangeNotifier {
  List<BinRtv> _itemsBin;
  String binIdRtv;


  List<BinRtv> get itemsBins => _itemsBin;

  Future<void> getAllBinRtv() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);

    final url = '$kBaseUrl/api/getbinloc/$warehouseId';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;

      final List<BinRtv> list = [];
      data.forEach((map) {
        list.add(BinRtv.fromMap(map));
      });

      _itemsBin = list;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
