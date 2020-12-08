import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionReceiptRmBin with ChangeNotifier {
  final String binLocation;
  ProductionReceiptRmBin({
    this.binLocation,
  });

  ProductionReceiptRmBin copyWith({
    String binLocation,
  }) {
    return ProductionReceiptRmBin(
      binLocation: binLocation ?? this.binLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'binLocation': binLocation,
    };
  }

  factory ProductionReceiptRmBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProductionReceiptRmBin(
      binLocation: map['binCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptRmBin.fromJson(String source) => ProductionReceiptRmBin.fromMap(json.decode(source));

  @override
  String toString() => 'ProductionReceiptRmBin(binLocation: $binLocation)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ProductionReceiptRmBin &&
      o.binLocation == binLocation;
  }

  @override
  int get hashCode => binLocation.hashCode;
  }
