import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';

class ProductionIssueItemModel with ChangeNotifier {
   String itemCode;
   String itemName;
   String oldItemCode;
   String oldItemName;
   String binCode;
   String fgBatch;
   String unitMsr;
   String canChangeitem;
  String binCodeDestination;
   double availableQty;
  double remainingQty;
  double putQty;
  double totQty;
  int lineNum;
  List<ProductionIssueItemBatchModel> batchList;
  ProductionIssueItemModel({
    this.itemCode,
    this.itemName,
    this.oldItemCode,
    this.oldItemName,
    this.binCode,
    this.fgBatch,
    this.canChangeitem,
    this.unitMsr,
    this.binCodeDestination,
    this.availableQty,
    this.remainingQty,
    this.putQty,
    this.totQty,
    this.batchList,
    this.lineNum,
  });

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': itemName,
      'item': lineNum,
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
      oldItemCode: map['oldItemCode'] ?? '',
      oldItemName: map['olddscription'] ?? '',
      availableQty: map['openQty'] ?? 0.0,
      remainingQty: map['quantity'] ?? 0.0,
      unitMsr: map['unitMsr'] ?? '',
      canChangeitem: map['canChangeitem']?? '' ,
      binCode: map['binCode'] ?? '',
      putQty: 0.0,
      totQty: 0.0,
      fgBatch: map['fgBatch'] ?? '',
      lineNum: map['lineNum'] ?? 0,
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueItemModel.fromJson(String source) =>
      ProductionIssueItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionIssueItemModel(canChangeitem: $canChangeitem,itemCode: $itemCode,totQty: $totQty, itemName: $itemName, binCode: $binCode, fgBatch: $fgBatch, binCodeDestination: $binCodeDestination, availableQty: $availableQty, remainingQty: $remainingQty, putQty: $putQty, batchList: $batchList, unitMsr: $unitMsr)';
  }
}
