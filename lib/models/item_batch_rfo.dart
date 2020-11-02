import 'dart:convert';

import 'package:flutter/material.dart';

class ItemBatchRfo with ChangeNotifier {
  final String batchNo;
  final double availableQty;
  final DateTime expiredDate;
  ItemBatchRfo({
    this.batchNo,
    this.availableQty,
    this.expiredDate,
  });

  ItemBatchRfo copyWith({
    String batchNo,
    double availableQty,
    DateTime expiredDate,
  }) {
    return ItemBatchRfo(
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

  factory ItemBatchRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBatchRfo(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBatchRfo.fromJson(String source) =>
      ItemBatchRfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'ItemBatchRfo(batchNo: $batchNo, availableQty: $availableQty, expiredDate: $expiredDate)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemBatchRfo &&
        o.batchNo == batchNo &&
        o.availableQty == availableQty &&
        o.expiredDate == expiredDate;
  }

  @override
  int get hashCode =>
      batchNo.hashCode ^ availableQty.hashCode ^ expiredDate.hashCode;
}
