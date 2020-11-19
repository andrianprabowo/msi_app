import 'dart:convert';

import 'package:flutter/material.dart';

class PickBatchSo with ChangeNotifier {
  final String batchNo;
  final String uom;
  double availableQty;
  double remainQty;
  double pickQty;
  final DateTime expiredDate;
  PickBatchSo({
    this.batchNo,
    this.uom,
    this.availableQty,
    this.remainQty,
    this.pickQty,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'batchNo': batchNo,
      'batchQuantity': pickQty,
      // 'pickQty': pickQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory PickBatchSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickBatchSo(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      remainQty: map['remainQty'] ?? 0.0,
      pickQty: 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PickBatchSo.fromJson(String source) =>
      PickBatchSo.fromMap(json.decode(source));

  @override
  String toString() =>
      'PickBatchSo(batchNo: $batchNo, uom: $uom, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate, remainQty: $remainQty)';
}
