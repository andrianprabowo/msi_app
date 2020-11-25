import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionIssueNumberModel with ChangeNotifier {
  final String pickNumber;
  final DateTime pickDate;
  final String pickRemark;
  final String plant;
  final String plantName;
  ProductionIssueNumberModel({
    this.pickNumber,
    this.pickDate,
    this.pickRemark,
    this.plant,
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
      plantName: map['cardName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueNumberModel.fromJson(String source) =>
      ProductionIssueNumberModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionIssueNumberModel(pickNumber: $pickNumber, docDate: $pickDate, pickRemark: $pickRemark, plant: $plant, plantName: $plantName)';
  }
}
