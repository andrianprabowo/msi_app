import 'dart:convert';

import 'package:flutter/material.dart';

class PutBatchSi with ChangeNotifier {
  final String batchNo;
  final double availableQty;
  double putQty;
  final DateTime expiredDate;
  PutBatchSi({
    this.batchNo,
    this.availableQty,
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

  factory PutBatchSi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PutBatchSi(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      putQty: map['putqty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PutBatchSi.fromJson(String source) =>
      PutBatchSi.fromMap(json.decode(source));

  @override
  String toString() =>
      'PutBatchSi(batchNo: $batchNo, availableQty: $availableQty,putQty: $putQty, expiredDate: $expiredDate)';
}
