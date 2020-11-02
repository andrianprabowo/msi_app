import 'dart:convert';

import 'package:flutter/material.dart';

class PickListBinRtv with ChangeNotifier {
  final String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  PickListBinRtv({
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

  factory PickListBinRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickListBinRtv(
      binLocation: map['binCode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlqty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickListBinRtv.fromJson(String source) =>
      PickListBinRtv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickListBinRtv(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
