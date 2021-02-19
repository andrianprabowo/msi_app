import 'dart:convert';

import 'package:flutter/material.dart';

class PickBatch with ChangeNotifier {
  final String batchNo;
  final String uom;
  String bin;
  double availableQty;
  double remainQty;
  double pickQty;

  int totalRemain;
  int show;

  final DateTime expiredDate;
  PickBatch({
    this.batchNo,
    this.uom,
    this.bin,
    this.availableQty,
    this.remainQty,
    this.pickQty,
    this.expiredDate,
    this.totalRemain,
    this.show,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemStorageLocation': bin,
      'batchNo': batchNo,
      'batchQuantity': pickQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory PickBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickBatch(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      bin: map['itemStorageLocation'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      pickQty: 0.0,
      remainQty: map['remainQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
      totalRemain: 0,
      show: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickBatch.fromJson(String source) =>
      PickBatch.fromMap(json.decode(source));

  @override
  String toString() =>
      'PickBatch(show: $show, totalRemain: $totalRemain, batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate, uom: $uom , remainQty: $remainQty, bin: $bin)';
}
