import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBin with ChangeNotifier {
   String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  InventoryDispatchBin({
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

  factory InventoryDispatchBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBin(
      binLocation: map['bincode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlQty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBin.fromJson(String source) =>
      InventoryDispatchBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchBin(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
