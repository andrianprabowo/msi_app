import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionReceiptRMItemListBatchListModel with ChangeNotifier {
  final String batchNo;
  final String uom;
  double availableQty;
  double pickQty;
  final DateTime expiredDate;
  ProductionReceiptRMItemListBatchListModel({
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
      'pickQty': pickQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory ProductionReceiptRMItemListBatchListModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionReceiptRMItemListBatchListModel(
      batchNo: map['batchNo'] ?? '',
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      pickQty:  0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptRMItemListBatchListModel.fromJson(String source) =>
      ProductionReceiptRMItemListBatchListModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductionReceiptRMItemListBatchListModel(batchNo: $batchNo, availableQty: $availableQty, pickQty: $pickQty,  expiredDate: $expiredDate. uom:$uom)';
}
