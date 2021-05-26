import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionIssueNumberModel with ChangeNotifier {
  final String pickNumber;
  final DateTime pickDate;
  final String pickRemark;
  final String plant;
  final String productCode;
  final String productName;
  final String uom;
  final double quantity;
  final String plantName;
  double totalQty;
  double totalRemain;
  ProductionIssueNumberModel({
    this.pickNumber,
    this.pickDate,
    this.pickRemark,
    this.plant,
    this.productCode,
    this.productName,
    this.uom,
    this.totalQty,
    this.totalRemain,
    this.quantity,
    this.plantName,
  });

  Map<String, dynamic> toMap() {
    return {
      'doNo': pickNumber,
      'deliveryDate': pickDate?.toIso8601String(),
      'remark': pickRemark,
      'plant': plant,
      'plantName': plantName,
    };
  }

  factory ProductionIssueNumberModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionIssueNumberModel(
      pickNumber: map['uDocNum'] ?? '',
      pickDate: DateTime.parse(map['docDate']),
      pickRemark: map['pickRemark'] ?? '',
      plant: map['cardCode'] ?? '',
      productCode: map['itemFgCode'] ?? '',
      productName: map['itemFgName'] ?? '',
      uom: map['uom'] ?? '',
      totalQty: map['totalQuantity'] ?? 0.0,
      totalRemain: map['totalRemain'] ?? 0.0,
      quantity: map['quantity'] ?? '',
      plantName: map['cardName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueNumberModel.fromJson(String source) =>
      ProductionIssueNumberModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionIssueNumberModel(productCode: $productCode,totalRemain: $totalRemain,totalQty: $totalQty, productName: $productName,uom: $uom,quantity: $quantity,pickNumber: $pickNumber, docDate: $pickDate, pickRemark: $pickRemark, plant: $plant, plantName: $plantName)';
  }
}
