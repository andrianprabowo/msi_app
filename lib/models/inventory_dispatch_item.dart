import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchItem with ChangeNotifier {
  final String itemCode;
  final String description;
  double openQty;
  double quantity;
  double pickedQty;
  String fgBatch;
  final String unitMsr;
  final int val;
  String itemStorageLocation;
  InventoryDispatchItem({
    this.itemCode,
    this.description,
    this.openQty,
    this.quantity,
    this.pickedQty,
    this.fgBatch,
    this.unitMsr,
    this.val,
    this.itemStorageLocation,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'dscription': description,
      'openQty': openQty,
      'quantity': quantity,
      'pickedQty': pickedQty,
      'fgBatch': fgBatch,
      'unitMsr': unitMsr,
      'val': val,
      'itemStorageLocation': itemStorageLocation,
    };
  }

  factory InventoryDispatchItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return InventoryDispatchItem(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      pickedQty: 0.0,
      fgBatch: map['fgBatch'] ?? '',
      unitMsr: map['unitMsr'] ?? '',
      val: map['val'] ?? 0,
      itemStorageLocation: map['itemStorageLocation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchItem.fromJson(String source) => InventoryDispatchItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchItem(itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, pickedQty: $pickedQty, fgBatch: $fgBatch, unitMsr: $unitMsr, val: $val, itemStorageLocation: $itemStorageLocation)';
  }

}
