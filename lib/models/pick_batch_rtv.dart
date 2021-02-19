import 'dart:convert';

import 'package:flutter/material.dart';

class PickBatchRtv with ChangeNotifier {
  final String batchNo;
  final String uom;
  String bin;
  double availableQty;
  double remainQty;
  double pickQty;

  int totalRemain;
  int show;

  final DateTime expiredDate;
  PickBatchRtv({
    this.batchNo,
    this.uom,
    this.bin,
    this.availableQty,
    this.remainQty,
    this.pickQty,
    this.totalRemain,
    this.show,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemStorageLocation': bin,
      'batchNo': batchNo,
      'batchQuantity': pickQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory PickBatchRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickBatchRtv(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      bin: map['itemStorageLocation'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      remainQty: map['remainQty'] ?? 0.0,
      pickQty: 0.0,
      totalRemain: 0,
      show: 0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PickBatchRtv.fromJson(String source) =>
      PickBatchRtv.fromMap(json.decode(source));

  @override
  String toString() =>
      'PickBatchRtv(show: $show, totalRemain: $totalRemain, batchNo: $batchNo, uom: $uom, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate, remainQty: $remainQty, bin: $bin)';
}
