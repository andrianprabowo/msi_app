import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:msi_app/models/stock_counting_item.dart';

class StockCountingBin with ChangeNotifier {
   int status;
  String binLocation;
  final double capacity;
  final String warehouse;
  final double avlQty;
  StockCountingBin({
    this.status,
    this.binLocation,
    this.capacity,
    this.warehouse,
    this.avlQty,
  });

  StockCountingBin copyWith({
    String binLocation,
    double capacity,
    String warehouse,
    double avlQty,
    List<StockCountingItem> pickItemList,
  }) {
    return StockCountingBin(
      binLocation: binLocation ?? this.binLocation,
      capacity: capacity ?? this.capacity,
      warehouse: warehouse ?? this.warehouse,
      avlQty: avlQty ?? this.avlQty,
    );
  }

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
      status: map['status'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingBin.fromJson(String source) =>
      StockCountingBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockCountingBin(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, avlQty: $avlQty)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StockCountingBin &&
        o.binLocation == binLocation &&
        o.capacity == capacity &&
        o.warehouse == warehouse &&
        o.avlQty == avlQty;
  }

  @override
  int get hashCode {
    return binLocation.hashCode ^
        capacity.hashCode ^
        warehouse.hashCode ^
        avlQty.hashCode;
  }
}
