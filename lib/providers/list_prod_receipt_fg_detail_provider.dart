import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/list_prod_receipt_fg_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ListProdReceiptFgDetailProvider with ChangeNotifier {
  List<ListProdReceiptFgDetail> _items = [];
  ListProdReceiptFgDetail _selected;

  List<ListProdReceiptFgDetail> get items => _items;
  ListProdReceiptFgDetail get selected => _selected;

  Future<void> getAllData(int idGrpodlvHeader) async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/receiptfg/$idGrpodlvHeader';
    // final url = '$kBaseUrl/tgrpo/tgrpo/api/grpo/402178';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
     // print("data gajelas $_selected");

      if (data == null) return;

      final List<ListProdReceiptFgDetail> list = [];
      data.forEach((map) {
        list.add(ListProdReceiptFgDetail.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void selectPo(ListProdReceiptFgDetail purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  Future<Map<String, dynamic>> cancelDocument(int idGrpodlvHeader) async {
    final url = '$kBaseUrl/tgrpo/tgrpo/api/receiptfg/$idGrpodlvHeader';

    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // final binId = await Prefs.getString(Prefs.binId);
    // final warehouseId = await Prefs.getString(Prefs.warehouseId);

    // _selected.idGrpoHeader = items.first.idGrpoHeader;
    // _selected.storageLocation = binId;
    // _selected.pickItemList = detailList;
    print("PUT? $_selected");

    try {
      var response = await http.put(
        url,
        headers: headers,
        body: _selected.toJson(),
      );
      print("PUT $_selected");

      print(response.request);
      print(_selected.toJson());

      print('Status: ${response.statusCode}');
      final data = json.decode(response.body) as Map;
      print(data);
      return data;
    } catch (error) {
      // print(error);
      print("?????????/");
      // throw error;
    }
  }
}
