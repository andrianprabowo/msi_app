import 'dart:convert';

import 'package:flutter/material.dart';

class ItemBatch with ChangeNotifier {
  final String batchNo;
  final double availableQty;
  final DateTime expiredDate;
  ItemBatch({
    this.batchNo,
    this.availableQty,
    this.expiredDate,
  });

  ItemBatch copyWith({
    String batchNo,
    double availableQty,
    DateTime expiredDate,
  }) {
    return ItemBatch(
      batchNo: batchNo ?? this.batchNo,
      availableQty: availableQty ?? this.availableQty,
      expiredDate: expiredDate ?? this.expiredDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'batchNo': batchNo,
      'avlQty': availableQty,
      'expDate': expiredDate?.toIso8601String(),
    };
  }

  factory ItemBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBatch(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBatch.fromJson(String source) =>
      ItemBatch.fromMap(json.decode(source));

  @override
  String toString() =>
      'ItemBatch(batchNo: $batchNo, availableQty: $availableQty, expiredDate: $expiredDate)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemBatch &&
        o.batchNo == batchNo &&
        o.availableQty == availableQty &&
        o.expiredDate == expiredDate;
  }

  @override
  int get hashCode =>
      batchNo.hashCode ^ availableQty.hashCode ^ expiredDate.hashCode;
}
