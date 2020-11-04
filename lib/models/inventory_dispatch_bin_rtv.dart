import 'dart:convert';

import 'package:flutter/material.dart';

class InventoryDispatchBinRtv with ChangeNotifier {
   String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  InventoryDispatchBinRtv({
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

  factory InventoryDispatchBinRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchBinRtv(
      binLocation: map['bincode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlQty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchBinRtv.fromJson(String source) =>
      InventoryDispatchBinRtv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchBinRtv(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
