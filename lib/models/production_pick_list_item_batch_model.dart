import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionPickListItemBatchModel with ChangeNotifier {
  final String batchNo;
  final String uom;
  String bin;
  double availableQty;
  double pickQty;
  double remainQty;
  int totalRemain;
  int show;
  
  final DateTime expiredDate;
  ProductionPickListItemBatchModel({
    this.batchNo,
    this.uom,
    this.bin,
    this.availableQty,
    this.pickQty,
    this.remainQty,
    this.totalRemain,
    this.show,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemStorageLocation': bin,
      'batchNo': batchNo,
      'batchQuantity': pickQty,
      //'pickQty': pickQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory ProductionPickListItemBatchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionPickListItemBatchModel(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      bin: map['itemStorageLocation'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      pickQty: map['pickQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
      totalRemain: 0,
      show: 0,
      remainQty: map['remainQty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionPickListItemBatchModel.fromJson(String source) =>
      ProductionPickListItemBatchModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductionPickListItemBatchModel(show: $show, totalRemain: $totalRemain, batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate, uom:$uom, bin:$bin)';
}
