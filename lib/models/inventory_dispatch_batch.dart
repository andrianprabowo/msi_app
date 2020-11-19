import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBatch with ChangeNotifier {
  final String batchNo;
  final String uom;
  double availableQty;
  double pickQty;
  double remainQty;
  final DateTime expiredDate;
  InventoryDispatchBatch({
    this.batchNo,
    this.uom,
    this.availableQty,
    this.pickQty,
    this.remainQty,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'batchNo': batchNo,
      'batchQuantity': pickQty,
      'pickQty': pickQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory InventoryDispatchBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBatch(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      remainQty: map['remainQty'] ?? 0.0,
      pickQty:  0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBatch.fromJson(String source) =>
      InventoryDispatchBatch.fromMap(json.decode(source));

  @override
  String toString() =>
      'InventoryDispatchBatch(batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty,  uom: $uom,  remainQty: $remainQty,  expiredDate: $expiredDate)';
}
