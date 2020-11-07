import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/models/pick_list_whs_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';

class PickListWhsSoProvider with ChangeNotifier {
  List<PickListWhsSo> _items = [];
  PickListWhsSo _selected;
  

  // List<PickListBinSo> _itembin = [];
  // PickListBinSo _selectedBin;

  List<PickListWhsSo> get items => _items;
  PickListWhsSo get selected => _selected;

  // List<PickListBinSo> get itembin => _itembin;
  // PickListBinSo get selectedBinSo => _selectedBin;

  List<PickItemReceiveSo> get detailList {
    return _selected.pickItemList.where((item) => item.pickedQty > 0).toList();
  }


  Future<void> getPlByWarehouse() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getsobywhs/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<PickListWhsSo> list = [];
      data.forEach((map) {
        list.add(PickListWhsSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  PickListWhsSo findByPickNumber(String pickNumber) {
    return _items.firstWhere((element) => element.pickNumber == pickNumber);
  }

  void selectPickList(PickListWhsSo pickListWhsSo) {
    _selected = pickListWhsSo;
    notifyListeners();
  }

  // void selectBin(PickListBinSo pickListBinSo) {
  //   _selectedBin = pickListBinSo;
  //   notifyListeners();
  // }

  // void updateQtyNBinNonBatch(ProductionPickListItemModel productionPickListItemModel, double qty, String bin) {
  //   productionPickListItemModel.pickedQty = qty;
  //   productionPickListItemModel.itemStorageLocation = bin;
  //   notifyListeners();
  //   print('Update Qty & Bin Loc Non batch: $productionPickListItemModel');
  // }

  Future<Map<String, dynamic>> createPickList() async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listpickso';


    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // _selectedBin.binLocation = _selectedBin.toString();
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
