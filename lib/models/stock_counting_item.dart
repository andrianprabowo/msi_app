import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';

class StockCountingItem with ChangeNotifier {
  final String itemCode;
  final String itemDesc;
  double openQty;
  double quantity;
  double remainingQty;
  final String uom;
  final String filename;
  final String docNum;
  final String fgBatch;
  List<ItemBatch> batchList;
  StockCountingItem({
    this.itemCode,
    this.itemDesc,
    this.openQty,
    this.quantity,
    this.remainingQty,
    this.uom,
    this.filename,
    this.docNum,
    this.fgBatch,
    this.batchList,
  });

  StockCountingItem copyWith({
    String itemCode,
    String itemDesc,
    double openQty,
    double quantity,
    double remainingQty,
    String uom,
    String filename,
    String docNum,
    String fgBatch,
    List<ItemBatch> batchList,
  }) {
    return StockCountingItem(
      itemCode: itemCode ?? this.itemCode,
      itemDesc: itemDesc ?? this.itemDesc,
      openQty: openQty ?? this.openQty,
      quantity: quantity ?? this.quantity,
      remainingQty: remainingQty ?? this.remainingQty,
      uom: uom ?? this.uom,
      filename: filename ?? this.filename,
      docNum: docNum ?? this.docNum,
      fgBatch: fgBatch ?? this.fgBatch,
      batchList: batchList ?? this.batchList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': itemDesc,
      'grQuantity': quantity.toString(),
      'uom': uom,
      'filename': 'Receipt Vendor',
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StockCountingItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StockCountingItem(
      itemCode: map['itemCode'] ?? '',
      itemDesc: map['itemDesc'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: 0.0,
      remainingQty: map['remainingQty'] ?? 0.0,
      uom: map['unitMsr'] ?? '',
      filename: 'Receipt Vendor',
      docNum: map['docNum'] ?? '',
      fgBatch: map['fgBatch'] ?? '',
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingItem.fromJson(String source) =>
      StockCountingItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockCountingItem(itemCode: $itemCode, itemDesc: $itemDesc, openQty: $openQty, quantity: $quantity, remainingQty: $remainingQty, uom: $uom, filename: $filename, docNum: $docNum, fgBatch: $fgBatch, batchList: $batchList)';
  }
}
