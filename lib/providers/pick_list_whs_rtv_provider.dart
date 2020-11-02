import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/models/pick_list_whs_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickListWhsRtvProvider with ChangeNotifier {
  List<PickListWhsRtv> _items = [];
  PickListWhsRtv _selected;

  List<PickListWhsRtv> get items => _items;
  PickListWhsRtv get selected => _selected;

  List<PickItemReceiveRtv> get detailList {
    return _selected.pickItemList.where((item) => item.pickedQty > 0).toList();
  }

  Future<void> getPlByWarehouse() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getrvbywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickListWhsRtv> list = [];
      data.forEach((map) {
        list.add(PickListWhsRtv.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickListWhsRtv findByPickNumber(String pickNumber) {
    return _items.firstWhere((element) => element.pickNumber == pickNumber);
  }

  void selectPickList(PickListWhsRtv pickListWhsSo) {
    _selected = pickListWhsSo;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createPickList() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listrvpl';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    _selected.pickItemList = detailList;

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
