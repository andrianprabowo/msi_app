import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';

class StockCountingItemProvider with ChangeNotifier {
  List<StockCountingItem> _allItems;
  List<StockCountingItem> _items = [];
  StockCountingItem _selected;
  StockCountingBin _selectedBin;

  List<StockCountingItem> get allItems => _allItems;
  StockCountingItem get selected => _selected;
  StockCountingBin get selectedBin => _selectedBin;

  List<StockCountingItem> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == 'Y') {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.quantity = totalBatch;
      }
      // calculate remaining qty
      // detail.remainingQty = detail.openQty - detail.quantity;
     
    });

    // print("... .... ... ... ... ...$em");
    return _items;
  }

  List<StockCountingItem> get itemCheck {
    return _items.where((item) => item.quantity > 0).toList();
  }

  List<StockCountingItem>  itemSameBin(BuildContext context) {

    final selectedBin =
          Provider.of<StockCountingBinProvider>(context, listen: false)
              .selected;
    return _items
        .where((item) => item.itemStorageLocation == selectedBin.binLocation)
        .toList();
  }

  Future<void> getAllItems() async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final url = '$kBaseUrl/api/getallitem/whscode=$warehouseId';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print('isi data item $data');
      if (data == null) return;

      final List<StockCountingItem> list = [];
      data.forEach((map) {
        list.add(StockCountingItem.fromMap(map));
      });

      _allItems = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StockCountingItem findByItemCode(String itemCode) {
    return _allItems.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatch(
    StockCountingItem itemPo,
    List<StockCountingBatch> itemBatch,
  ) {
    itemPo.batchList = itemBatch;
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void addBatchQtyBatchDate(
      StockCountingItem itemPo, StockCountingBatch itemBatch) {
    itemPo.batchList.add(itemBatch);
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void removeBatch(StockCountingItem itemPo, StockCountingBatch itemBatch) {
    itemPo.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch: $itemBatch');
  }

  void removeItem(StockCountingItem item) {
    _items.remove(item);
    notifyListeners();
    print('delete : $item');
  }

  bool contains(StockCountingItem item) {
    for (StockCountingItem e in items) {
      if (e == item) return true;
    }
    return false;
  }

  void selectPo(StockCountingBin bin) {
    _selectedBin.binLocation = bin.binLocation;
    notifyListeners();
  }

  // void selectItem(StockCountingItem bin) {
  //   _selected.unitMsr = bin.unitMsr;
  //   notifyListeners();
  // }

  void inputQty(StockCountingItem item, double qty, BuildContext context) {
    // update qty
    item.quantity = qty;

    final contain = contains(item);
    print(contain);
    if (contain) {
      final searchItem =
          items.where((element) => element.itemCode == item.itemCode).first;
      searchItem.quantity = qty;
    } else {
      // set storage location
      final selectedBin =
          Provider.of<StockCountingBinProvider>(context, listen: false)
              .selected;
      item.itemStorageLocation = selectedBin.binLocation;
      items.add(item);
    }
    notifyListeners();
    print('inputQty : $qty');
  }

  void selectItemCode(StockCountingItem itemSelect) {
    _selected.itemCode = itemSelect.itemCode;
    notifyListeners();
  }

  void clearPickedItems() {
    _items = [];
    notifyListeners();
  }
}
