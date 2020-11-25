import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/models/production_receipt_rm_number_list_model.dart';
import 'package:msi_app/providers/production_receipt_rm_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMNumberListProvider with ChangeNotifier {
  List<ProductionReceiptRMNumberListModel> _items = [];
  ProductionReceiptRMNumberListModel _selected;

  List<ProductionReceiptRMNumberListModel> get items => _items;
  ProductionReceiptRMNumberListModel get selected => _selected;

  List<ProductionReceiptRMItemListModel> get detailList {
    return _selected.itemList.where((item) => item.pickedQty > 0).toList();
  }

  Future<void> getPlByWarehouse(String binCode) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    print('object$binCode');
    final url =
        '$kBaseUrl/api/getPaPRMbywhs/whscode=$warehouseId&bincode=$binCode';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptRMNumberListModel> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptRMNumberListModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionReceiptRMNumberListModel findByDocNumber(String docNumber) {
    return _items.firstWhere((element) => element.docNumber == docNumber);
  }

  void selectPickList(ProductionReceiptRMNumberListModel inventoryDispatchDetail) {
    _selected = inventoryDispatchDetail;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createInventoryDispatch(BuildContext context) async {
    var url = '$kBaseUrl/tgrpo/tgrpo/api/listputawyprod';
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final header =  Provider.of<ProductionReceiptRMProvider>(context, listen: false).selected;

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
