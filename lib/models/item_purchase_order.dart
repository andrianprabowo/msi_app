import 'dart:convert';

import 'package:flutter/material.dart';

class ItemPurchaseOrder with ChangeNotifier {
  final String itemCode;
  final String description;
  final double openQty;
  final double quantity;
  final String uom;
  final String docNum;
  ItemPurchaseOrder({
    this.itemCode,
    this.description,
    this.openQty,
    this.quantity,
    this.uom,
    this.docNum,
  });

  ItemPurchaseOrder copyWith({
    String itemCode,
    String description,
    double openQty,
    double quantity,
    String uom,
    String docNum,
  }) {
    return ItemPurchaseOrder(
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

  factory ItemPurchaseOrder.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemPurchaseOrder(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      uom: map['unitMsr'] ?? '',
      docNum: map['docNum'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemPurchaseOrder.fromJson(String source) =>
      ItemPurchaseOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemPurchaseOrder(itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, uom: $uom, docNum: $docNum)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemPurchaseOrder &&
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
