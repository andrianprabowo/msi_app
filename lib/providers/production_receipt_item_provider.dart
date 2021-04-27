import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductionReceiptItemProvider with ChangeNotifier {
  List<ProductionReceiptItemModel> _items;
  ProductionReceiptItemModel _selected;

  ProductionReceiptItemModel get selected => _selected;


  List<ProductionReceiptItemModel> get items {
    _items.forEach((detail) {
      if (detail.fgBatch == 'Y') {
        // calculate total batch qty
        var totalBatch = 0.0;
        var totalBatchReject = 0.0;
        detail.batchList.forEach((batch) {
          totalBatch = totalBatch + batch.availableQty;
          totalBatchReject = totalBatchReject + batch.rejectQty;
        });
        detail.quantity = totalBatch;
        detail.quantityReject = totalBatchReject;
      }
      // calculate remaining qty
      detail.remainingQty =
          detail.openQty - (detail.quantity + detail.quantityReject);
    });

    // _items = _items.where((item) => item.remainingQty > 0).toList();

    return _items;
  }

  Future<void> getPoDetailByDocNum(String docNum) async {
    final url = '$kBaseUrl/api/GetWODetail/docnum=$docNum';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<ProductionReceiptItemModel> list = [];
      data.forEach((map) {
        list.add(ProductionReceiptItemModel.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ProductionReceiptItemModel findByItemCode(String itemCode) {
    return _items.firstWhere((element) => element.itemCode == itemCode);
  }

  void addBatch(ProductionReceiptItemModel itemPo,
      ProductionReceiptItemBatchModel itemBatch) {
    itemPo.batchList.add(itemBatch);
    notifyListeners();
    print('Added Batch: $itemBatch');
  }

  void removeBatch(ProductionReceiptItemModel itemPo,
      ProductionReceiptItemBatchModel itemBatch) {
    itemPo.batchList.remove(itemBatch);
    notifyListeners();
    print('Removed Batch: $itemBatch');
  }

  void inputQty(
      ProductionReceiptItemModel itemPo, double qty, double qtyReject) {
    itemPo.quantity = qty;
    itemPo.quantityReject = qtyReject;
    notifyListeners();
    print('Update Complete Qty & Reject Qty: $itemPo');
  }
}
