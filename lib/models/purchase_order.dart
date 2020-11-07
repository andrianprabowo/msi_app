import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';

class PurchaseOrder with ChangeNotifier {
  final int docEntry;
  final DateTime postingDate;
  final String poNumber;
  final DateTime docDate;
  final String vendorCode;
  final String vendorName;
  String storageLocation;
  String plant;
  String storageLocationName;
  final String docnum;
  List<ItemPurchaseOrder> detailList;
  PurchaseOrder({
    this.docEntry,
    this.postingDate,
    this.poNumber,
    this.docDate,
    this.vendorCode,
    this.vendorName,
    this.storageLocation,
    this.plant,
    this.storageLocationName,
    this.docnum,
    this.detailList,
  });

  Map<String, dynamic> toMap() {
    return {
      'postingDate': DateTime.now().toIso8601String(),
      'poNo': poNumber,
      'deliveryDate': docDate?.toIso8601String(),
      'kdVendor': vendorCode,
      'nmVendor': vendorName,
      'fileName':'GRPO MOBILE',
      'storageLocation': storageLocation ?? '',
      'plant': plant ?? '',
      'storageLocationName': storageLocationName ?? '',
      'docnum': poNumber,
      'details': detailList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PurchaseOrder(
      docEntry: map['h_DocEntry'] ?? 0,
      poNumber: map['h_U_DocNum'] ?? '',
      docDate: DateTime.parse(map['h_DocDate']),
      vendorCode: map['h_CardCode'] ?? '',
      vendorName: map['h_CardName'] ?? '',
      detailList: map['detailList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseOrder.fromJson(String source) =>
      PurchaseOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurchaseOrder(docEntry: $docEntry, poNumber: $poNumber, docDate: $docDate, vendorCode: $vendorCode, vendorName: $vendorName, plant: $plant, detailList: $detailList)';
  }
}
