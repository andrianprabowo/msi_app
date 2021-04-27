import 'dart:convert';

import 'package:flutter/material.dart';

class PutBatch with ChangeNotifier {
  final String batchNo;
  final String uom;
  final double availableQty;
  String bin;
  double putQty;
  final DateTime expiredDate;
  PutBatch({
    this.batchNo,
    this.uom,
    this.bin,
    this.availableQty,
    this.putQty,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemStorageLocation': bin,
      'batchNo': batchNo,
      'batchQuantity': putQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory PutBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PutBatch(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      bin: map['itemStorageLocation'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      putQty: map['putqty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PutBatch.fromJson(String source) =>
      PutBatch.fromMap(json.decode(source));

  @override
  String toString() =>
      'PutBatch(batchNo: $batchNo, bin: $bin, availableQty: $availableQty,putQty: $putQty, expiredDate: $expiredDate,uom: $uom)';
}
