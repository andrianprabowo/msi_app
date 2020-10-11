import 'dart:convert';

import 'package:flutter/material.dart';

class PickBatch with ChangeNotifier {
  final String batchNo;
  final double availableQty;
  final DateTime expiredDate;
  PickBatch({
    this.batchNo,
    this.availableQty,
    this.expiredDate,
  });

  PickBatch copyWith({
    String batchNo,
    double availableQty,
    DateTime expiredDate,
  }) {
    return PickBatch(
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

  factory PickBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickBatch(
      batchNo: map['batchNo'] ?? '',
      availableQty: map['avlqty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PickBatch.fromJson(String source) =>
      PickBatch.fromMap(json.decode(source));

  @override
  String toString() =>
      'PickBatch(batchNo: $batchNo, availableQty: $availableQty, expiredDate: $expiredDate)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PickBatch &&
        o.batchNo == batchNo &&
        o.availableQty == availableQty &&
        o.expiredDate == expiredDate;
  }

  @override
  int get hashCode =>
      batchNo.hashCode ^ availableQty.hashCode ^ expiredDate.hashCode;
}
