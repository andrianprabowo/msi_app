import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/enter_gl.dart';
import 'package:msi_app/utils/constants.dart';

class ItemGlProvider extends ChangeNotifier {
  List<EnterGl> _enterGl;
  String itemGl;

  List<EnterGl> get itemsGl => _enterGl;

  Future<void> getEnterGl(String docNum) async {
    // final warehouseId = await Prefs.getString(Prefs.warehouseId);
     

    final url = '$kBaseUrl/api/getWoseqno/docnum=$docNum';
    // final url = '$kBaseUrl/api/getWoseqno/docnum=MS2020080000010';
    

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;

      final List<EnterGl> list = [];
      data.forEach((map) {
        list.add(EnterGl.fromMap(map));
      });

      _enterGl = list;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
