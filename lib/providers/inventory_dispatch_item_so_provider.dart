import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_batch_so.dart';
import 'package:msi_app/models/inventory_dispatch_item_so.dart';
import 'package:msi_app/providers/inventory_dispatch_header_so_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class InventoryDispatchItemSoProvider with ChangeNotifier {
  List<InventoryDispatchItemSo> _items;
  InventoryDispatchItemSo _selected;
  InventoryDispatchItemSo get selected => _selected;

  List<InventoryDispatchItemSo> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == "Y") {
        // calculate total batch qty
        var totalBatch = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.pickQty;
        });
        detail.pickedQty = totalBatch;
      }
      // calculate remaining qty
      detail.quantity = detail.openQty - detail.pickedQty;
    });

    // _items = _items.where((item) => item.quantity > 0).toList();

    return _items;
  }

  Future<void> getInventItemByPlNo(
      BuildContext context, String docNumber) async {
    print('object bb ???aa');

    final binProv =
        Provider.of<InventoryDispatchHeaderSoProvider>(context, listen: false).selected;
    final aa = binProv.binCode;
    print('object bb $aa');
    // print('object bb ${json.decode(binProv.selected.binLocation)}');
    // print('object aaa $aa');
    final url =
        '$kBaseUrl/api/getplitemsbySOIDPno/docnum=$docNumber&bincode=$aa';
        // '$kBaseUrl/api/getplitemsbySOIDPno/docnum=$docNumber&bincode=WMSISTFG-UNLOADING%20BIN';
    // '$kBaseUrl/api/getplitemsbySOIDPno/docnum=$docNumber&bincode=${binProv.selected.binLocation}';
    // final url = '$kBaseUrl/api/getplitemsbyIDPno/docnum=MS2020070000007';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<InventoryDispatchItemSo> list = [];
      data.forEach((map) {
        list.add(InventoryDispatchItemSo.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  InventoryDispatchItemSo findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatchList(
    InventoryDispatchItemSo inventoryDispatchItem,
    List<InventoryDispatchBatchSo> batchList,
  ) {
    inventoryDispatchItem.batchList = batchList;
    notifyListeners();
    print('Added Batch List: $batchList');
  }

  void removeBatchItem(
    InventoryDispatchItemSo inventoryDispatchItem,
    InventoryDispatchBatchSo itemBatch,
  ) {
    inventoryDispatchItem.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Item Batch: $itemBatch');
  }

  void inputQtyNonBatch(
      InventoryDispatchItemSo inventoryDispatchItem, double qty) {
    inventoryDispatchItem.pickedQty = qty;
    // inventoryDispatchItem.itemStorageLocation = itemStorageLocation;
    notifyListeners();
    print('Update Qty Non batch: $inventoryDispatchItem');
  }

  void inputBinNonBatch(InventoryDispatchItemSo inventoryDispatchItem,
      String itemStorageLocation) {
    // inventoryDispatchItem.pickedQty = qty;
    inventoryDispatchItem.itemStorageLocation = itemStorageLocation;
    notifyListeners();
    print('Update Bin Non batch: $inventoryDispatchItem');
  }

  void selectPo(InventoryDispatchItemSo purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }
}
