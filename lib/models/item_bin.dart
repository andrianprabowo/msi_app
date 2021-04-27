import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch.dart';

class ItemBin with ChangeNotifier {
  final String itemCode;
  final String itemName;
  final String binCode;
  final String fgBatch;
  final String uom;
  final String unitMsr;
  double numInBuy;
  String binCodeDestination;
  final double availableQty;
  double remainingQty;
  double putQty;
  List<PutBatch> batchList;
  ItemBin({
    this.itemCode,
    this.itemName,
    this.binCode,
    this.fgBatch,
    this.unitMsr,
    this.uom,
    this.numInBuy,
    this.binCodeDestination,
    this.availableQty,
    this.remainingQty,
    this.putQty,
    this.batchList,
  });

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'fgBatch': fgBatch,
      'materialDesc': itemName,
      'itemStorageLocation': binCodeDestination,
      'grQuantity': putQty,
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ItemBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBin(
      itemCode: map['itemCode'] ?? '',
      itemName: map['itemName'] ?? '',
      binCode: map['binCode'] ?? '',
      fgBatch: map['fgBatch'] ?? '',
      uom: map['uom'] ?? '',
      unitMsr: map['unitMsr'] ?? '',
      numInBuy: map['numInBuy'] ?? 0.0,
      binCodeDestination: map['binCodeDestination'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      putQty: 0.0,
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBin.fromJson(String source) =>
      ItemBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemBin(itemCode: $itemCode,numInBuy: $numInBuy, itemName: $itemName, binCode: $binCode, fgBatch: $fgBatch, binCodeDestination: $binCodeDestination, availableQty: $availableQty, remainingQty: $remainingQty, putQty: $putQty, batchList: $batchList,uom: $uom)';
  }
}
