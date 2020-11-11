import 'dart:convert';

import 'package:flutter/material.dart';

class ItemBatchSi with ChangeNotifier {
  final String batchNo;
  final double availableQty;
  final DateTime expiredDate;
  ItemBatchSi({
    this.batchNo,
    this.availableQty,
    this.expiredDate,
  });

  ItemBatchSi copyWith({
    String batchNo,
    double availableQty,
    DateTime expiredDate,
  }) {
    return ItemBatchSi(
      batchNo: batchNo ?? this.batchNo,
      availableQty: availableQty ?? this.availableQty,
      expiredDate: expiredDate ?? this.expiredDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'batchNo': batchNo,
      'batchQuantity': availableQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory ItemBatchSi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBatchSi(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBatchSi.fromJson(String source) =>
      ItemBatchSi.fromMap(json.decode(source));

  @override
  String toString() =>
      'ItemBatchSi(batchNo: $batchNo, availableQty: $availableQty, expiredDate: $expiredDate)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemBatchSi &&
        o.batchNo == batchNo &&
        o.availableQty == availableQty &&
        o.expiredDate == expiredDate;
  }

  @override
  int get hashCode =>
      batchNo.hashCode ^ availableQty.hashCode ^ expiredDate.hashCode;
}
