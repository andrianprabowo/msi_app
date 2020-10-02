import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class PickItemReceiveProvider extends ChangeNotifier {
  List<PickItemReceive> _items;

  List<PickItemReceive> get items => _items;

  Future<List<PickItemReceive>> getPlItemReceiveByPo(String pickNumber) async {
    final url = '$kBaseUrl/api/getplitemsbyplno/docnum=$pickNumber';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      final List<PickItemReceive> list = [];
      data.forEach((map) {
        list.add(PickItemReceive.fromMap(map));
      });
      _items = list;
      return _items;
    } catch (error) {
      throw error;
    }
  }
}
