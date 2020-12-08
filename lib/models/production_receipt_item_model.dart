import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';

class ProductionReceiptItemModel with ChangeNotifier {
  final String itemCode;
  final String description;
  double openQty;
  double quantity;
  double quantityReject;
  double remainingQty;
  final String uom;
  final String docNum;
  final String fgBatch;
  String itemStorageLocation;
  List<ProductionReceiptItemBatchModel> batchList;
  ProductionReceiptItemModel({
    this.itemCode,
    this.description,
    this.openQty,
    this.quantity,
    this.quantityReject,
    this.remainingQty,
    this.uom,
    this.docNum,
    this.fgBatch,
    this.itemStorageLocation,
    this.batchList,
  });

  ProductionReceiptItemModel copyWith({
    String itemCode,
    String description,
    double openQty,
    double quantity,
    double quantityReject,
    double remainingQty,
    String uom,
    String docNum,
    String fgBatch,
    List<ProductionReceiptItemBatchModel> batchList,
  }) {
    return ProductionReceiptItemModel(
      itemCode: itemCode ?? this.itemCode,
      description: description ?? this.description,
      openQty: openQty ?? this.openQty,
      quantity: quantity ?? this.quantity,
      quantityReject: quantityReject ?? this.quantityReject,
      remainingQty: remainingQty ?? this.remainingQty,
      uom: uom ?? this.uom,
      docNum: docNum ?? this.docNum,
      fgBatch: fgBatch ?? this.fgBatch,
      batchList: batchList ?? this.batchList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': description,
      'grfgQuantity': quantity,
      'qrfgRejectQty': quantityReject,
      'uom': uom,
      'itemStorageLocation': itemStorageLocation,
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductionReceiptItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionReceiptItemModel(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: 0.0,
      quantityReject: 0.0,
      remainingQty: map['remainingQty'] ?? 0.0,
      uom: map['unitMsr'] ?? '',
      docNum: map['docNum'] ?? '',
      fgBatch: map['fgBatch'] ?? '',
      itemStorageLocation: map['binCode'] ?? '',
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptItemModel.fromJson(String source) =>
      ProductionReceiptItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionReceiptItemModel(itemStorageLocation: $itemStorageLocation, itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, quantityReject: $quantityReject, remainingQty: $remainingQty, uom: $uom, docNum: $docNum, fgBatch: $fgBatch, batchList: $batchList)';
  }
}
