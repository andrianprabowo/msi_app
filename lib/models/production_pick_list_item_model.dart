import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';

class ProductionPickListItemModel with ChangeNotifier {
  final String itemCode;
  final String description;
  double openQty;
  double quantity;
  double pickedQty;

  final String unitMsr;
  final int val;
  String itemStorageLocation;
  String fgBatch;
  List<ProductionPickListItemBatchModel> batchList;

  ProductionPickListItemModel({
    this.itemCode,
    this.description,
    this.openQty,
    this.quantity,
    this.pickedQty,
    this.unitMsr,
    this.val,
    this.itemStorageLocation,
    this.fgBatch,
    this.batchList,
  });

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': description,
      'openQty': openQty,
      'quantity': quantity,
      'grQuantity': pickedQty,
      'fgBatch':fgBatch,
      'uom': unitMsr,
      'val': val,
      // 'itemStorageLocation': itemStorageLocation,
      'listBatches': batchList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductionPickListItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionPickListItemModel(
      itemCode: map['itemCode'] ?? '',
      description: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      pickedQty: map['grQuantity'] ?? 0.0,
      unitMsr: map['unitMsr'] ?? '',
      val: map['val'] ?? 0,
      itemStorageLocation: map['itemStorageLocation'] ?? '',
      fgBatch: map['fgBatch'] ?? '',
      batchList: map['batchList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionPickListItemModel.fromJson(String source) =>
      ProductionPickListItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionPickListItemModel(itemCode: $itemCode, description: $description, openQty: $openQty, quantity: $quantity, pickedQty: $pickedQty, unitMsr: $unitMsr, val: $val, itemStorageLocation: $itemStorageLocation, fgBatch: $fgBatch, batchList: $batchList)';
  }
}
