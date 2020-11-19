import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBatchRtv with ChangeNotifier {
  final String batchNo;
  final String uom;
  double availableQty;
  double pickQty;
  double remainQty;
  final DateTime expiredDate;
  InventoryDispatchBatchRtv({
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

  factory InventoryDispatchBatchRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBatchRtv(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      pickQty: map['pickQty'] ?? 0.0,
      remainQty: map['remainQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBatchRtv.fromJson(String source) =>
      InventoryDispatchBatchRtv.fromMap(json.decode(source));

  @override
  String toString() =>
      'InventoryDispatchBatchRtv(batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty, remainQty: $remainQty, uom: $uom,  expiredDate: $expiredDate)';
}
