import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionIssueItemBatchModel with ChangeNotifier {
  final String batchNo;
  final String uom;
  final double availableQty;
  double putQty;
  final DateTime expiredDate;
  ProductionIssueItemBatchModel({
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

  factory ProductionIssueItemBatchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionIssueItemBatchModel(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      putQty: map['putqty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueItemBatchModel.fromJson(String source) =>
      ProductionIssueItemBatchModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductionIssueItemBatchModel(batchNo: $batchNo, availableQty: $availableQty,putQty: $putQty, expiredDate: $expiredDate, uom:$uom)';
}
