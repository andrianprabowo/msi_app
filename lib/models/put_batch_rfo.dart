import 'dart:convert';

import 'package:flutter/material.dart';

class PutBatchRfo with ChangeNotifier {
  final String batchNo;
  final double availableQty;
  final String uom;
  double putQty;
  final DateTime expiredDate;
  PutBatchRfo({
    this.batchNo,
    this.availableQty,
    this.uom,
    this.putQty,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'batchNo': batchNo,
      'batchQuantity': putQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory PutBatchRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PutBatchRfo(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      uom: map['uom'] ?? '',
      putQty: map['putqty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PutBatchRfo.fromJson(String source) =>
      PutBatchRfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'PutBatchRfo(batchNo: $batchNo, availableQty: $availableQty,putQty: $putQty,uom: $uom, expiredDate: $expiredDate)';
}
