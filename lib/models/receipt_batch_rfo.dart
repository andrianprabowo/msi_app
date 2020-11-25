import 'dart:convert';

import 'package:flutter/material.dart';

class ReceiptBatchRfo with ChangeNotifier {
  final String batchNo;
  final String uom;
  final double availableQty;
  double putQty;
  final DateTime expiredDate;
  ReceiptBatchRfo({
    this.batchNo,
    this.uom,
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

  factory ReceiptBatchRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReceiptBatchRfo(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      putQty: map['putqty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceiptBatchRfo.fromJson(String source) =>
      ReceiptBatchRfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'ReceiptBatchRfo(batchNo: $batchNo, availableQty: $availableQty,putQty: $putQty, expiredDate: $expiredDate,uom: $uom)';
}
