import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_item_model.dart';

class ProductionIssueModel with ChangeNotifier {
  String pickNumber;
  DateTime pickDate;
  String pickRemark;
  final String binCode;
  String plant;
  String plantName;
  double totalQty;
  double totalRemain;
  final String fileName;
  List<ProductionIssueItemModel> itemBinList;
  ProductionIssueModel({
    this.pickNumber,
    this.pickDate,
    this.pickRemark,
    this.binCode,
    this.plant,
    this.plantName,
    this.totalQty,
    this.totalRemain,
    this.fileName,
    this.itemBinList,
  });

  Map<String, dynamic> toMap() {
    return {
      'doNo': pickNumber,
      'deliveryDate': pickDate?.toIso8601String(),
      'remark': pickRemark,
      'storageLocation': binCode,
      'postingDate': DateTime.now().toIso8601String(),
      'plant': plant,
      'plantName': plantName,
      'filename': 'Production Issue (Raw Mat)',
      'details': itemBinList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductionIssueModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionIssueModel(
      binCode: map['binCode'] ?? '',
      plant: map['plant'] ?? '',
      plantName: map['plantName'] ?? '',
      fileName: map['fileName'] ?? '',
      totalQty: map['total'] ?? 0.0,
      totalRemain: map['totalRemain'] ?? 0.0,
      itemBinList: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueModel.fromJson(String source) =>
      ProductionIssueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionIssueModel(binCode: $binCode, totalQty: $totalQty, totalRemain: $totalRemain plant: $plant, plantName: $plantName, fileName: $fileName, itemBinList: $itemBinList)';
  }
}
