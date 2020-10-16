import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch.dart';

class ItemBin with ChangeNotifier {
  final String itemCode;
  final String itemName;
  final String binCode;
  String binCodeDestination;
  final double availableQty;
  double remainingQty;
  double putQty;
  List<PutBatch> batchList;
  ItemBin({
    this.itemCode,
    this.itemName,
    this.binCode,
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
      'binCode': binCodeDestination,
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
      binCodeDestination: map['binCodeDestination'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      putQty: map['putQty'] ?? 0.0,
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBin.fromJson(String source) =>
      ItemBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemBin(itemCode: $itemCode, itemName: $itemName, binCode: $binCode, binCodeDestination: $binCodeDestination, availableQty: $availableQty, remainingQty: $remainingQty, putQty: $putQty, batchList: $batchList)';
  }
}
