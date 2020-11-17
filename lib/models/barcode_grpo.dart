import 'dart:convert';

import 'package:flutter/material.dart';

class BarcodeGrpo with ChangeNotifier {
  final String uDocNum;
  final String batchNo;
  final int docEntry;
  final String dscription;
  final DateTime expDate;
  final String itemCode;
  final int lineNum;
  final double quantity;
  BarcodeGrpo({
    this.uDocNum,
    this.batchNo,
    this.docEntry,
    this.dscription,
    this.expDate,
    this.itemCode,
    this.lineNum,
    this.quantity,
  });

  BarcodeGrpo copyWith({
    String uDocNum,
    String batchNo,
    int docEntry,
    String dscription,
    DateTime expDate,
    String itemCode,
    int lineNum,
    double quantity,
  }) {
    return BarcodeGrpo(
      uDocNum: uDocNum ?? this.uDocNum,
      batchNo: batchNo ?? this.batchNo,
      docEntry: docEntry ?? this.docEntry,
      dscription: dscription ?? this.dscription,
      expDate: expDate ?? this.expDate,
      itemCode: itemCode ?? this.itemCode,
      lineNum: lineNum ?? this.lineNum,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uDocNum': uDocNum,
      'batchNo': batchNo,
      'docEntry': docEntry,
      'dscription': dscription,
      'expDate': expDate?.toIso8601String(),
      'itemCode': itemCode,
      'lineNum': lineNum,
      'quantity': quantity,
    };
  }

  factory BarcodeGrpo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return BarcodeGrpo(
      uDocNum: map['uDocNum'] ?? '',
      batchNo: map['batchNo'] ?? '',
      docEntry: map['docEntry'] ?? 0,
      dscription: map['dscription'] ?? '',
      expDate: DateTime.parse(map['expDate']),
      itemCode: map['itemCode'] ?? '',
      lineNum: map['lineNum'] ?? 0,
      quantity: map['quantity'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BarcodeGrpo.fromJson(String source) => BarcodeGrpo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BarcodeGrpo(uDocNum: $uDocNum, batchNo: $batchNo, docEntry: $docEntry, dscription: $dscription, expDate: $expDate, itemCode: $itemCode, lineNum: $lineNum, quantity: $quantity)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is BarcodeGrpo &&
      o.uDocNum == uDocNum &&
      o.batchNo == batchNo &&
      o.docEntry == docEntry &&
      o.dscription == dscription &&
      o.expDate == expDate &&
      o.itemCode == itemCode &&
      o.lineNum == lineNum &&
      o.quantity == quantity;
  }

  @override
  int get hashCode {
    return uDocNum.hashCode ^
      batchNo.hashCode ^
      docEntry.hashCode ^
      dscription.hashCode ^
      expDate.hashCode ^
      itemCode.hashCode ^
      lineNum.hashCode ^
      quantity.hashCode;
  }
}
