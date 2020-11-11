import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class StockCountingBin with ChangeNotifier {
   final String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  StockCountingBin({
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

  factory StockCountingBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StockCountingBin(
      binLocation: map['binCode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlqty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingBin.fromJson(String source) =>
      StockCountingBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockCountingBin(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
