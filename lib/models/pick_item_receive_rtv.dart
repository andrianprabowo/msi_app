import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch_rtv.dart';

class PickItemReceiveRtv with ChangeNotifier {
  final String itemCode;
  final String description;
  double openQty;
  double quantity;
  double pickedQty;
  String fgBatch;
  final String unitMsr;
  final int val;
  String itemStorageLocation;
  List<PickBatchRtv> batchList;

  PickItemReceiveRtv({
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
      'quantity': quantity,
      'grQuantity': pickedQty,
      'uom': unitMsr,
      'val': val,
      'itemStorageLocation': itemStorageLocation,
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PickItemReceiveRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickItemReceiveRtv(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      fgBatch: map['fgBatch'] ?? '',
      pickedQty:0.0,
      unitMsr: map['unitMsr'] ?? '',
      val: map['val'] ?? 0,
      itemStorageLocation: map['itemStorageLocation'] ?? '',
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PickItemReceiveRtv.fromJson(String source) =>
      PickItemReceiveRtv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickItemReceiveRtv(itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, pickedQty: $pickedQty, fgBatch: $fgBatch, unitMsr: $unitMsr, val: $val, itemStorageLocation: $itemStorageLocation, batchList: $batchList)';
  }
}
