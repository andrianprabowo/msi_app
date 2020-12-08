import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';

class StockCountingBinProvider with ChangeNotifier {
  List<StockCountingBin> _items = [];
  var _showAllBin = false;
  StockCountingBin _selected;


  List<StockCountingBin> get items {
    return _showAllBin ? _items : _items.take(5).toList();
  }
  StockCountingBin get selected => _selected;

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }
  void selectStagingBin(StockCountingBin stagingBin) {
    _selected = stagingBin;
    notifyListeners();
  }

  

  Future<void> getPlBinList(BuildContext context,) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final header =
    Provider.of<StockCountingHeaderProvider>(context, listen: false).selected;
    final docnum = header.pickNumber;
    final url =
        '$kBaseUrl/api/getstcbin/whscode=$warehouseId&docnum=$docnum';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StockCountingBin> list = [];
      data.forEach((map) {
        list.add(StockCountingBin.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StockCountingBin findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }


  void addNewItem(
    StockCountingBin itemPo,
    List<StockCountingItem> itemBatch,
  ) {
    itemPo.pickItemList = itemBatch;
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void addNewItemBatchDate(StockCountingBin itemPo, StockCountingItem itemBatch) {
    itemPo.pickItemList.add(itemBatch);
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void removeNewItem(StockCountingBin itemPo, StockCountingItem itemBatch) {
    itemPo.pickItemList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch: $itemBatch');
  }

  // void inputQty(StockCountingBin itemPo, double qty) {
  //   itemPo.quantity = qty;
  //   notifyListeners();
  //   print('Update Qty: $itemPo');
  // }
}
