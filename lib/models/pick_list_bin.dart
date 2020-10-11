import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch.dart';

class PickListBin with ChangeNotifier {
  final String binLocation;
  final double capacity;
  final String warehouse;
  final double qty;
  List<PickBatch> batchList;
  PickListBin({
    this.binLocation,
    this.capacity,
    this.warehouse,
    this.qty,
    this.batchList,
  });

  PickListBin copyWith({
    String binLocation,
    double capacity,
    String warehouse,
    double qty,
    List<PickBatch> batchList,
  }) {
    return PickListBin(
      binLocation: binLocation ?? this.binLocation,
      capacity: capacity ?? this.capacity,
      warehouse: warehouse ?? this.warehouse,
      qty: qty ?? this.qty,
      batchList: batchList ?? this.batchList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'binLocation': binLocation,
      'capacity': capacity,
      'warehouse': warehouse,
      'qty': qty,
      'batchList': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PickListBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickListBin(
      binLocation: map['binCode'] ?? '',
      capacity: map['capacity'] ?? 0.0,
      warehouse: map['warehouse'] ?? '',
      qty: map['qty'] ?? 0.0,
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PickListBin.fromJson(String source) =>
      PickListBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickListBin(binLocation: $binLocation, capacity: $capacity, warehouse: $warehouse, qty: $qty, batchList: $batchList)';
  }
}
