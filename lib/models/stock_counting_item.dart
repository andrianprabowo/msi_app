import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_batch.dart';

class StockCountingItem with ChangeNotifier {
  String itemCode;
  final String description;
  double openQty;
  double quantity;
  double pickedQty;
  String fgBatch;
  String unitMsr;
  final int val;
  String itemStorageLocation;
  List<StockCountingBatch> batchList;

  StockCountingItem({
    this.itemCode,
    this.description,
    this.openQty,
    this.quantity,
    this.pickedQty,
    this.fgBatch,
    this.unitMsr,
    this.val,
    this.itemStorageLocation,
    this.batchList,
  });

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': description,
      'openQty': openQty,
      'requirementQty': quantity,
      'grQuantity': pickedQty,
      'uom': unitMsr,
      'val': val,
      'num': itemStorageLocation,
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StockCountingItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StockCountingItem(
      itemCode: map['itemCode'] ?? '',
      description: map['itemDesc'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: 0.0,
      fgBatch: map['fgBatch'] ?? '',
      pickedQty: 0.0,
      unitMsr: map['unitMsr'] ?? '',
      val: map['val'] ?? 0,
      itemStorageLocation: map['itemStorageLocation'] ?? '',
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingItem.fromJson(String source) =>
      StockCountingItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockCountingItem(itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, pickedQty: $pickedQty, fgBatch: $fgBatch, unitMsr: $unitMsr, val: $val, itemStorageLocation: $itemStorageLocation, batchList: $batchList)';
  }
}
