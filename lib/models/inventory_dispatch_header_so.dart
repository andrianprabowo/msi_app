import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:msi_app/models/inventory_dispatch_detail_so.dart';

class InventoryDispatchHeaderSo with ChangeNotifier {
  final String binCode;

  List<InventoryDispatchDetailSo> itemDispatchDetail;
  InventoryDispatchHeaderSo({
    this.binCode,
    this.itemDispatchDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'storageLocation': binCode,
      'itemDispatchDetail': itemDispatchDetail?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory InventoryDispatchHeaderSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return InventoryDispatchHeaderSo(
      binCode: map['binCode'] ?? '',
      itemDispatchDetail: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchHeaderSo.fromJson(String source) => InventoryDispatchHeaderSo.fromMap(json.decode(source));

  @override
  String toString() => 'InventoryDispatchHeaderSo(binCode: $binCode, itemDispatchDetail: $itemDispatchDetail)';

  
}
