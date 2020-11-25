import 'dart:convert';

import 'package:flutter/material.dart';

class ItemBatchRfo with ChangeNotifier {
  final String batchNo;
  final String uom;
  final double availableQty;
  final DateTime expiredDate;
  double putQty;
  ItemBatchRfo({
    this.batchNo,
    this.uom,
    this.availableQty,
    this.expiredDate,
    this.putQty,
  });

  

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
      uom: map['uom'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
      expiredDate: DateTime.parse(map['expDate']),
      putQty: map['putqty'] ?? 0.0,

    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBatchRfo.fromJson(String source) =>
      ItemBatchRfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'ItemBatchRfo(batchNo: $batchNo, uom: $uom, availableQty: $availableQty, expiredDate: $expiredDate, putQty: $putQty)';

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
