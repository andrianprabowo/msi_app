import 'dart:convert';

import 'package:flutter/material.dart';

class PickListBinSo with ChangeNotifier {
  final String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  PickListBinSo({
    this.binLocation,
    this.capacity,
    this.warehouse,
    this.avlQty,
  });

  Map<String, dynamic> toMap() {
    return {
      'binLocation': binLocation,
      'capacity': capacity,
      'warehouse': warehouse,
      'avlQty': avlQty,
    };
  }

  factory PickListBinSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickListBinSo(
      binLocation: map['binCode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlqty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickListBinSo.fromJson(String source) =>
      PickListBinSo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickListBinSo(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
