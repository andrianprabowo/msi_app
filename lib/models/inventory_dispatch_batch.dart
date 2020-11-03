import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBatch with ChangeNotifier {
  final String batchNo;
  double availableQty;
  double pickQty;
  final DateTime expiredDate;
  InventoryDispatchBatch({
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

  factory InventoryDispatchBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBatch(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      pickQty: map['pickQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBatch.fromJson(String source) =>
      InventoryDispatchBatch.fromMap(json.decode(source));

  @override
  String toString() =>
      'InventoryDispatchBatch(batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate)';
}
