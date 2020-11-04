import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBatchSo with ChangeNotifier {
  final String batchNo;
  double availableQty;
  double pickQty;
  final DateTime expiredDate;
  InventoryDispatchBatchSo({
    this.batchNo,
    this.availableQty,
    this.pickQty,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'batchNo': batchNo,
      'batchQuantity': availableQty,
      'pickQty': pickQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory InventoryDispatchBatchSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBatchSo(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      pickQty: map['pickQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBatchSo.fromJson(String source) =>
      InventoryDispatchBatchSo.fromMap(json.decode(source));

  @override
  String toString() =>
      'InventoryDispatchBatchSo(batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate)';
}
