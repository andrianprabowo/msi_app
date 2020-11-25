import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';

class ProductionIssueItemModel with ChangeNotifier {
  final String itemCode;
  final String itemName;
  final String binCode;
  final String fgBatch;
  final String unitMsr;
  String binCodeDestination;
  final double availableQty;
  double remainingQty;
  double putQty;
  List<ProductionIssueItemBatchModel> batchList;
  ProductionIssueItemModel({
    this.itemCode,
    this.itemName,
    this.binCode,
    this.fgBatch,
    this.unitMsr,
    this.binCodeDestination,
    this.availableQty,
    this.remainingQty,
    this.putQty,
    this.batchList,
  });

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': itemName,
      'itemStorageLocation': binCodeDestination,
      'grQuantity': putQty,
      'quantity': remainingQty,
      'openQty': availableQty,
      'uom': unitMsr,
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductionIssueItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionIssueItemModel(

      itemCode: map['itemCode'] ?? '',
      itemName: map['dscription'] ?? '',
      availableQty: map['openQty'] ?? 0.0,
      remainingQty: map['quantity'] ?? 0.0,
      unitMsr: map['unitMsr'] ?? '',
      binCode: map['binCode'] ?? '',
      putQty: 0.0,
      fgBatch: map['fgBatch'] ?? '',
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueItemModel.fromJson(String source) =>
      ProductionIssueItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionIssueItemModel(itemCode: $itemCode, itemName: $itemName, binCode: $binCode, fgBatch: $fgBatch, binCodeDestination: $binCodeDestination, availableQty: $availableQty, remainingQty: $remainingQty, putQty: $putQty, batchList: $batchList, unitMsr: $unitMsr)';
  }
}
