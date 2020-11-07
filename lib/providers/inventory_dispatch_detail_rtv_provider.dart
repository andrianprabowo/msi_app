import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail_rtv.dart';
import 'package:msi_app/models/inventory_dispatch_item_rtv.dart';
import 'package:msi_app/providers/inventory_dispatch_header_Rtv_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';



class InventoryDispatchDetailRtvProvider with ChangeNotifier {
  List<InventoryDispatchDetailRtv> _items = [];
  InventoryDispatchDetailRtv _selected;

  List<InventoryDispatchDetailRtv> get items => _items;
  InventoryDispatchDetailRtv get selected => _selected;

  List<InventoryDispatchItemRtv> get detailList {
    return _selected.itemList.where((item) => item.pickedQty > 0).toList();
  }

  Future<void> getPlByWarehouse(String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    print('object$binCode');
    final url =
        '$kBaseUrl/api/getRVIDPbywhs/whscode=$warehouseId&bincode=$binCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<InventoryDispatchDetailRtv> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchDetailRtv.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchDetailRtv findByDocNumber(String docNumber) {
    return _items.firstWhere((element) => element.docNumber == docNumber);
  }

  void selectPickList(InventoryDispatchDetailRtv inventoryDispatchDetail) {
    _selected = inventoryDispatchDetail;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createInventoryDispatch(BuildContext context) async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listrvidp';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final header =  Provider.of<InventoryDispatchHeaderRtvProvider>(context, listen: false).selected;

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
