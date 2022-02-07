import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';

class ProductionIssueItemChangeModel with ChangeNotifier {
  final String itemCode;
  final String itemName;
  
   String oldItemCode;
   String oldItemName;
  List<ProductionIssueItemBatchModel> batchList;
  ProductionIssueItemChangeModel({
    this.itemCode,
    this.itemName,
    this.oldItemCode,
    this.oldItemName,
  });

  Map<String, dynamic> toMap() {
    return {
      'materialNo': itemCode,
      'materialDesc': itemName,
    };
  }

  factory ProductionIssueItemChangeModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionIssueItemChangeModel(

      itemCode: map['itemCode'] ?? '',
      itemName: map['dscription'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueItemChangeModel.fromJson(String source) =>
      ProductionIssueItemChangeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionIssueItemChangeModel(itemCode: $itemCode, itemName: $itemName)';
  }
}
