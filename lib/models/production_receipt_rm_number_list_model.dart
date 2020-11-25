import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';

class ProductionReceiptRMNumberListModel with ChangeNotifier {
  final String docNumber;
  final DateTime docDate;
  final DateTime postingDate;
  final String cardCode;
  final String cardName;
  final String pickRemark;
  final String filename;
  String storageLocation;

  List<ProductionReceiptRMItemListModel> itemList;
  ProductionReceiptRMNumberListModel({
    this.docNumber,
    this.docDate,
    this.postingDate,
    this.cardCode,
    this.cardName,
    this.pickRemark,
    this.filename,
    this.storageLocation,
    this.itemList,
  });

  Map<String, dynamic> toMap() {
    return {
      'doNo': docNumber,
      'deliveryDate': docDate?.toIso8601String(),
      'postingDate': DateTime.now().toIso8601String(),
      'plant': cardCode,
      'plantName': cardName,
      'remark': pickRemark,
      'filename': 'Receipt (Raw Material)',
      'storageLocation': storageLocation,
      'details': itemList?.map((x) => x?.toMap())?.toList(),
    };
  }
  
  factory ProductionReceiptRMNumberListModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProductionReceiptRMNumberListModel(
      docNumber: map['uDocNum'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      cardCode: map['cardCode'] ?? '',
      cardName: map['cardName'] ?? '',
      pickRemark: map['pickRemark'] ?? '',
      filename: 'Inventory Dispatch',
      storageLocation: map['storageLocation'],
      itemList: map['itemList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptRMNumberListModel.fromJson(String source) => ProductionReceiptRMNumberListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionReceiptRMNumberListModel(docNumber: $docNumber, docDate: $docDate, postingDate: $postingDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark, filename: $filename, storageLocation: $storageLocation, itemList: $itemList)';
  } 
}
