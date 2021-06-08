import 'dart:convert';

import 'package:flutter/material.dart';

class StockCountingBatch with ChangeNotifier {
  final String batchNo;
  final String uom;
  double availableQty;
  double pickQty;
  int flagSo;
  final DateTime expiredDate;
  StockCountingBatch({
    this.batchNo,
    this.uom,
    this.availableQty,
    this.pickQty,
    this.flagSo,
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

  factory StockCountingBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StockCountingBatch(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      flagSo: map['flagSo'] ?? 0.0,
      pickQty: 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingBatch.fromJson(String source) =>
      StockCountingBatch.fromMap(json.decode(source));

  @override
  String toString() =>
      'StockCountingBatch(batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty, flagSo: $flagSo, uom: $uom,  expiredDate: $expiredDate)';
}
