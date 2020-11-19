import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBatchSo with ChangeNotifier {
  final String batchNo;
  final String uom;
  double availableQty;
  double pickQty;
  double remainQty;
  final DateTime expiredDate;
  InventoryDispatchBatchSo({
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

  factory InventoryDispatchBatchSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBatchSo(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      remainQty: map['remainQty'] ?? 0.0,
      pickQty: 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBatchSo.fromJson(String source) =>
      InventoryDispatchBatchSo.fromMap(json.decode(source));

  @override
  String toString() =>
      'InventoryDispatchBatchSo(batchNo: $batchNo, uom: $uom, remainQty: $remainQty, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate)';
}
