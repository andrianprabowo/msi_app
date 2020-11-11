import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch_si.dart';

class ItemBinSi with ChangeNotifier {
  final String itemCode;
  final String itemName;
  final String binCode;
  final String fgBatch;
  String binCodeDestination;
  final double availableQty;
  double remainingQty;
  double putQty;
  List<PutBatchSi> batchList;
  ItemBinSi({
    this.itemCode,
    this.itemName,
    this.binCode,
    this.fgBatch,
    this.binCodeDestination,
    this.availableQty,
    this.remainingQty,
    this.putQty,
    this.batchList,
  });

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': itemName,
      'itemStorageLocation': binCodeDestination,
      'grQuantity': putQty,
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ItemBinSi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBinSi(
      itemCode: map['itemCode'] ?? '',
      itemName: map['itemName'] ?? '',
      binCode: map['binCode'] ?? '',
      fgBatch: map['fgBatch'] ?? '',
      binCodeDestination: map['binCodeDestination'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      putQty: 0.0,
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBinSi.fromJson(String source) =>
      ItemBinSi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemBinSi(itemCode: $itemCode, itemName: $itemName, binCode: $binCode, fgBatch: $fgBatch, binCodeDestination: $binCodeDestination, availableQty: $availableQty, remainingQty: $remainingQty, putQty: $putQty, batchList: $batchList)';
  }
}
