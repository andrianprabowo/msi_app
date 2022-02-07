import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';

class ProductionPickListModel with ChangeNotifier {
  final String pickNumber;
  final DateTime pickDate;
  DateTime postingDate;
  String cardCode;
  String cardName;
  final String pickRemark;
  final String filename;
  String storageLocation;
  List<ProductionPickListItemModel> pickItemList;

  ProductionPickListModel({
    this.pickNumber, 
    this.pickDate, 
    this.postingDate,
    this.cardCode, 
    this.cardName, 
    this.pickRemark, 
    this.filename,
    this.storageLocation,
    this.pickItemList,
  });

  Map<String, dynamic> toMap() {
    return {
      'doNo': pickNumber,
      'deliveryDate': pickDate?.toIso8601String(),
      'postingDate': postingDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'plant': cardCode,
      'plantName': cardName,
      'remark': pickRemark,
      'filename': 'Production Pick List (Raw Material)',
      'storageLocation': storageLocation,
      'details': pickItemList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductionPickListModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionPickListModel(
      pickNumber: map['uDocNum'] ?? '',
      pickDate: DateTime.parse(map['docDate']),
      cardCode: map['cardCode'] ?? '',
      cardName: map['cardName'] ?? '',
      pickRemark: map['pickRemark'] ?? '',
      filename: 'Pick List',
      storageLocation: map['storageLocation'] ?? '',
      pickItemList: map['pickItemList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionPickListModel.fromJson(String source) =>
      ProductionPickListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionPickListModel(pickNumber: $pickNumber, pickDate: $pickDate, postingDate: $postingDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark, filename: $filename, storageLocation: $storageLocation, pickItemList: $pickItemList)';
  }
}
