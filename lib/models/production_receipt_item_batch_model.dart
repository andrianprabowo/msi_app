import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionReceiptItemBatchModel with ChangeNotifier {
  final String batchNo;
  String bin;
  final double availableQty;
  final double rejectQty;
  final DateTime expiredDate;
  ProductionReceiptItemBatchModel({
    this.batchNo,
    this.bin,
    this.availableQty,
    this.rejectQty,
    this.expiredDate,
  });

  ProductionReceiptItemBatchModel copyWith({
    String batchNo,
    double availableQty,
    double rejectQty,
    DateTime expiredDate,
  }) {
    return ProductionReceiptItemBatchModel(
      batchNo: batchNo ?? this.batchNo,
      availableQty: availableQty ?? this.availableQty,
      rejectQty: rejectQty ?? this.rejectQty,
      expiredDate: expiredDate ?? this.expiredDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'batchNo': batchNo,
      'itemStorageLocation': bin,
      'batchQuantity': availableQty,
      'batchRejectQty': rejectQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory ProductionReceiptItemBatchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionReceiptItemBatchModel(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      bin: map['itemStorageLocation'] ?? '',
      rejectQty: 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptItemBatchModel.fromJson(String source) =>
      ProductionReceiptItemBatchModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProductionReceiptItemBatchModel(batchNo: $batchNo,bin: $bin, availableQty: $availableQty, rejectQty: $rejectQty, expiredDate: $expiredDate)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductionReceiptItemBatchModel &&
        o.batchNo == batchNo &&
        o.availableQty == availableQty &&
        o.rejectQty == rejectQty &&
        o.expiredDate == expiredDate;
  }

  @override
  int get hashCode =>
      batchNo.hashCode ^ availableQty.hashCode ^ rejectQty.hashCode ^ expiredDate.hashCode;
}
