import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail_rtv.dart';

class InventoryDispatchHeaderRtv with ChangeNotifier {
  final String binCode;

  List<InventoryDispatchDetailRtv> itemDispatchDetail;
  InventoryDispatchHeaderRtv({
    this.binCode,
    this.itemDispatchDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'storageLocation': binCode,
      'itemDispatchDetail': itemDispatchDetail?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory InventoryDispatchHeaderRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return InventoryDispatchHeaderRtv(
      binCode: map['binCode'] ?? '',
      itemDispatchDetail: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchHeaderRtv.fromJson(String source) => InventoryDispatchHeaderRtv.fromMap(json.decode(source));

  @override
  String toString() => 'InventoryDispatchHeaderRtv(binCode: $binCode, itemDispatchDetail: $itemDispatchDetail)';

  
}
