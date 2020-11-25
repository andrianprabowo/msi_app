import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/models/production_pick_list_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class ProductionPickListProvider with ChangeNotifier {
  List<ProductionPickListModel> _items = [];
  ProductionPickListModel _selected;

  List<ProductionPickListModel> get items => _items;
  ProductionPickListModel get selected => _selected;

  List<ProductionPickListItemModel> get detailList {
    return _selected.pickItemList.where((item) => item.pickedQty > 0).toList();
  }

  Future<void> getPlByWarehouse() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getprmbywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionPickListModel> list = [];
      data.forEach((map) {
        list.add(ProductionPickListModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionPickListModel findByPickNumber(String pickNumber) {
    return _items.firstWhere((element) => element.pickNumber == pickNumber);
  }

  void selectPickList(ProductionPickListModel productionPickListModel) {
    _selected = productionPickListModel;
    notifyListeners();
  }

  void setStagingBin(String stagingBin) {
    _selected.storageLocation = stagingBin;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createProductionPickList() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listplrm';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final binId = await Prefs.getString(Prefs.binId);
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final warehouseName = await Prefs.getString(Prefs.warehouseName);

    _selected.cardCode = warehouseId;
    _selected.cardName = warehouseName;
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
