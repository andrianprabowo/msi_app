import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';

class ProductionReceiptModel with ChangeNotifier {
  final int docEntry;
  final DateTime postingDate;
  final String poNumber;
  final DateTime docDate;
  String vendorCode;
  String vendorName;
  String storageLocation;
  String storageLocationName;
  //final String docnum;
  List<ProductionReceiptItemModel> detailList;
  ProductionReceiptModel({
    this.docEntry,
    this.postingDate,
    this.poNumber,
    this.docDate,
    this.vendorCode,
    this.vendorName,
    this.storageLocation,
    this.storageLocationName,
    //this.docnum,
    this.detailList,
  });

  Map<String, dynamic> toMap() {
    return {
      'postingDate': DateTime.now().toIso8601String(),
      'doNo': poNumber,
      'deliveryDate': docDate?.toIso8601String(),
      'plant': vendorCode,
      'plantName': vendorName,
      'storageLocation': storageLocation ?? '',
      'storageLocationName': storageLocationName ?? '',
      'filename':'Receipt From Production',
      //'docnum': poNumber,
      'details': detailList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductionReceiptModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionReceiptModel(
      docEntry: map['h_DocEntry'] ?? 0,
      poNumber: map['uDocNum'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendorCode: map['cardCode'] ?? '',
      vendorName: map['cardName'] ?? '',
      detailList: map['detailList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptModel.fromJson(String source) =>
      ProductionReceiptModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionReceiptModel(docEntry: $docEntry, poNumber: $poNumber, docDate: $docDate, vendorCode: $vendorCode, vendorName: $vendorName, detailList: $detailList)';
  }
}
