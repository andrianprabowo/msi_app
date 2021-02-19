import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionPickListBinModel with ChangeNotifier {
  String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  ProductionPickListBinModel({
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

  factory ProductionPickListBinModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionPickListBinModel(
      binLocation: map['binCode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      avlQty: map['avlQty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionPickListBinModel.fromJson(String source) =>
      ProductionPickListBinModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionPickListBinModel(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }
}
