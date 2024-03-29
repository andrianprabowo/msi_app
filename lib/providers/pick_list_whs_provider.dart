import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickListWhsProvider with ChangeNotifier {
  List<PickListWhs> _items = [];
  PickListWhs _selected;

  List<PickListWhs> get items => _items;
  PickListWhs get selected => _selected;

  List<PickItemReceive> get detailList {
    return _selected.pickItemList.where((item) => item.pickedQty > 0).toList();
  }

  Future<void> getPlByWarehouse() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getplbywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickListWhs> list = [];
      data.forEach((map) {
        list.add(PickListWhs.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickListWhs findByPickNumber(String pickNumber) {
    return _items.firstWhere((element) => element.pickNumber == pickNumber);
  }

  void selectPickList(PickListWhs pickListWhs) {
    _selected = pickListWhs;
    notifyListeners();
  }

  void setStagingBin(String stagingBin) {
    _selected.storageLocation = stagingBin;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createPickList() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/multilistgrpodlvs';

    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final binId = await Prefs.getString(Prefs.binId);
    final warehouseId = await Prefs.getString(Prefs.warehouseId);

    _selected.cardCode = warehouseId;
    _selected.storageLocation = binId;
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
