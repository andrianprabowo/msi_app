import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_bin.dart';

class PickItemReceive with ChangeNotifier {
  final String itemCode;
  final String description;
  final double openQty;
  final double quantity;
  final String unitMsr;
  List<PickListBin> binList;
  PickItemReceive({
    this.itemCode,
    this.description,
    this.openQty,
    this.quantity,
    this.unitMsr,
    this.binList,
  });

  PickItemReceive copyWith({
    String itemCode,
    String description,
    double openQty,
    double quantity,
    String unitMsr,
    List<PickListBin> binList,
  }) {
    return PickItemReceive(
      itemCode: itemCode ?? this.itemCode,
      description: description ?? this.description,
      openQty: openQty ?? this.openQty,
      quantity: quantity ?? this.quantity,
      unitMsr: unitMsr ?? this.unitMsr,
      binList: binList ?? this.binList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'description': description,
      'openQty': openQty,
      'quantity': quantity,
      'unitMsr': unitMsr,
      'binList': binList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PickItemReceive.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickItemReceive(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      unitMsr: map['unitMsr'] ?? '',
      binList: map['binList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PickItemReceive.fromJson(String source) =>
      PickItemReceive.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickItemReceive(itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, unitMsr: $unitMsr, binList: $binList)';
  }
}
