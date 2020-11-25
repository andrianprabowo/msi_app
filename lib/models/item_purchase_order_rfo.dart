import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch_rfo.dart';

class ItemPurchaseOrderRfo with ChangeNotifier {
  final String itemCode;
  final String description;
  final String cardCode;
  double openQty;
  double quantity;
  double remainingQty;
  final String uom;
  final String filename;
  final String docNum;
  final String fgBatch;
  List<ItemBatchRfo> batchList;
  ItemPurchaseOrderRfo({
    this.itemCode,
    this.description,
    this.cardCode,
    this.openQty,
    this.quantity,
    this.remainingQty,
    this.uom,
    this.filename,
    this.docNum,
    this.fgBatch,
    this.batchList,
  });

  ItemPurchaseOrderRfo copyWith({
    String itemCode,
    String description,
    double openQty,
    double quantity,
    double remainingQty,
    String uom,
    String filename,
    String docNum,
    String fgBatch,
    List<ItemBatchRfo> batchList,
  }) {
    return ItemPurchaseOrderRfo(
      itemCode: itemCode ?? this.itemCode,
      description: description ?? this.description,
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
      'materialDesc': description,
      'grQuantity': quantity,
      'uom': uom,
      'filename': 'Receipt Vendor',
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ItemPurchaseOrderRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemPurchaseOrderRfo(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      cardCode: map['cardCode'] ?? '',
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

  factory ItemPurchaseOrderRfo.fromJson(String source) =>
      ItemPurchaseOrderRfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemPurchaseOrderRfo(cardCode: $cardCode,itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, remainingQty: $remainingQty, uom: $uom, filename: $filename, docNum: $docNum, fgBatch: $fgBatch, batchList: $batchList)';
  }
}
