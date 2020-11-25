import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:msi_app/models/inventory_dispatch_detail.dart';

class ProductionReceiptRMBinListModel with ChangeNotifier {
  final String binCode;

  List<InventoryDispatchDetail> itemDispatchDetail;
  ProductionReceiptRMBinListModel({
    this.binCode,
    this.itemDispatchDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'storageLocation': binCode,
      'itemDispatchDetail': itemDispatchDetail?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductionReceiptRMBinListModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProductionReceiptRMBinListModel(
      binCode: map['binCode'] ?? '',
      itemDispatchDetail: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptRMBinListModel.fromJson(String source) => ProductionReceiptRMBinListModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductionReceiptRMBinListModel(binCode: $binCode, itemDispatchDetail: $itemDispatchDetail)';  
}
