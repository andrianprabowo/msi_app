import 'dart:convert';

import 'package:flutter/material.dart';

class PickListBin with ChangeNotifier {
  String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  PickListBin({
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

  factory PickListBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickListBin(
      binLocation: map['binCode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlqty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickListBin.fromJson(String source) =>
      PickListBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickListBin(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
