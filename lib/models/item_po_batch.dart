import 'dart:convert';

import 'package:flutter/material.dart';

class ItemPoBatch with ChangeNotifier {
  final String itemCode;
  final String description;
  final double openQty;
  final double quantity;
  final String uom;
  final String docNum;
  ItemPoBatch({
    this.itemCode,
    this.description,
    this.openQty,
    this.quantity,
    this.uom,
    this.docNum,
  });

  ItemPoBatch copyWith({
    String itemCode,
    String description,
    double openQty,
    double quantity,
    String uom,
    String docNum,
  }) {
    return ItemPoBatch(
      itemCode: itemCode ?? this.itemCode,
      description: description ?? this.description,
      openQty: openQty ?? this.openQty,
      quantity: quantity ?? this.quantity,
      uom: uom ?? this.uom,
      docNum: docNum ?? this.docNum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'dscription': description,
      'openQty': openQty,
      'quantity': quantity,
      'unitMsr': uom,
      'docNum': docNum,
    };
  }

  factory ItemPoBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemPoBatch(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      uom: map['unitMsr'] ?? '',
      docNum: map['docNum'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemPoBatch.fromJson(String source) =>
      ItemPoBatch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemPoBatch(itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, uom: $uom, docNum: $docNum)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemPoBatch &&
        o.itemCode == itemCode &&
        o.description == description &&
        o.openQty == openQty &&
        o.quantity == quantity &&
        o.uom == uom &&
        o.docNum == docNum;
  }

  @override
  int get hashCode {
    return itemCode.hashCode ^
        description.hashCode ^
        openQty.hashCode ^
        quantity.hashCode ^
        uom.hashCode ^
        docNum.hashCode;
  }
}
