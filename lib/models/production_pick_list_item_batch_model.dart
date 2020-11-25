import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionPickListItemBatchModel with ChangeNotifier {
  final String batchNo;
  final String uom;
  double availableQty;
  double pickQty;
  final DateTime expiredDate;
  ProductionPickListItemBatchModel({
    this.batchNo,
    this.uom,
    this.availableQty,
    this.pickQty,
    this.expiredDate,
  });

  Map<String, dynamic> toMap() {
    return {
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
      availableQty: map['avlQty'] ?? 0.0,
      pickQty: map['pickQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionPickListItemBatchModel.fromJson(String source) =>
      ProductionPickListItemBatchModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductionPickListItemBatchModel(batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate, uom:$uom)';
}
