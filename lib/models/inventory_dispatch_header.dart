import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:msi_app/models/inventory_dispatch_detail.dart';

class InventoryDispatchHeader with ChangeNotifier {
  final String binCode;

  List<InventoryDispatchDetail> itemDispatchDetail;
  InventoryDispatchHeader({
    this.binCode,
    this.itemDispatchDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'storageLocation': binCode,
      'itemDispatchDetail': itemDispatchDetail?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory InventoryDispatchHeader.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return InventoryDispatchHeader(
      binCode: map['binCode'] ?? '',
      itemDispatchDetail: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchHeader.fromJson(String source) => InventoryDispatchHeader.fromMap(json.decode(source));

  @override
  String toString() => 'InventoryDispatchHeader(binCode: $binCode, itemDispatchDetail: $itemDispatchDetail)';

  
}
