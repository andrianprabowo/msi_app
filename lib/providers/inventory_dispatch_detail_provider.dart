import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail.dart';
import 'package:msi_app/models/inventory_dispatch_item.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';

import 'inventory_dispatch_header_provider.dart';

class InventoryDispatchDetailProvider with ChangeNotifier {
  List<InventoryDispatchDetail> _items = [];
  InventoryDispatchDetail _selected;

  List<InventoryDispatchDetail> get items => _items;
  InventoryDispatchDetail get selected => _selected;

  List<InventoryDispatchItem> get detailList {
    return _selected.itemList.where((item) => item.pickedQty > 0).toList();
  }

  Future<void> getPlByWarehouse(String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    print('object$binCode');
    final url =
        '$kBaseUrl/api/getIDPbywhs/whscode=$warehouseId&bincode=$binCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<InventoryDispatchDetail> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchDetail.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchDetail findByDocNumber(String docNumber) {
    return _items.firstWhere((element) => element.docNumber == docNumber);
  }

  void selectPickList(InventoryDispatchDetail inventoryDispatchDetail) {
    _selected = inventoryDispatchDetail;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createInventoryDispatch(BuildContext context) async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listgrpodlvs';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final header =  Provider.of<InventoryDispatchHeaderProvider>(context, listen: false).selected;

    _selected.storageLocation = header.binCode;
    _selected.itemList = detailList;

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
