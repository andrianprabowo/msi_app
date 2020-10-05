import 'dart:convert';

import 'package:flutter/material.dart';

class ItemBin with ChangeNotifier {
  final String itemCode;
  final String itemName;
  final double availableQty;
  ItemBin({
    this.itemCode,
    this.itemName,
    this.availableQty,
  });

  ItemBin copyWith({
    String itemCode,
    String itemName,
    double availableQty,
  }) {
    return ItemBin(
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      availableQty: availableQty ?? this.availableQty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'itemName': itemName,
      'avlQty': availableQty,
    };
  }

  factory ItemBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBin(
      itemCode: map['itemCode'] ?? '',
      itemName: map['itemName'] ?? '',
      availableQty: map['avlQty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBin.fromJson(String source) =>
      ItemBin.fromMap(json.decode(source));

  @override
  String toString() =>
      'ItemBin(itemCode: $itemCode, itemName: $itemName, availableQty: $availableQty)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemBin &&
        o.itemCode == itemCode &&
        o.itemName == itemName &&
        o.availableQty == availableQty;
  }

  @override
  int get hashCode =>
      itemCode.hashCode ^ itemName.hashCode ^ availableQty.hashCode;
}
