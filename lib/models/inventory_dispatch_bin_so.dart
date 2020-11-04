import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBinSo with ChangeNotifier {
   String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  InventoryDispatchBinSo({
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

  factory InventoryDispatchBinSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBinSo(
      binLocation: map['bincode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlQty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBinSo.fromJson(String source) =>
      InventoryDispatchBinSo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchBinSo(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
