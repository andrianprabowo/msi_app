import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';

class PurchaseOrderRfo with ChangeNotifier {
  final int docEntry;
  final DateTime postingDate;
  final String poNumber;
  final DateTime docDate;
  final String vendorCode;
  final String vendorName;
  String storageLocation;
  String storageLocationName;
  final String docnum;
  List<ItemPurchaseOrderRfo> detailList;
  PurchaseOrderRfo({
    this.docEntry,
    this.postingDate,
    this.poNumber,
    this.docDate,
    this.vendorCode,
    this.vendorName,
    this.storageLocation,
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
      'storageLocation': storageLocation ?? '',
      'storageLocationName': storageLocationName ?? '',
      'docnum': poNumber,
      'details': detailList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PurchaseOrderRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PurchaseOrderRfo(
      docEntry: map['h_DocEntry'] ?? 0,
      poNumber: map['uDocNum'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendorCode: map['cardCode'] ?? '',
      vendorName: map['cardName'] ?? '',
      detailList: map['detailList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseOrderRfo.fromJson(String source) =>
      PurchaseOrderRfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurchaseOrderRfo(docEntry: $docEntry, poNumber: $poNumber, docDate: $docDate, vendorCode: $vendorCode, vendorName: $vendorName, detailList: $detailList)';
  }
}
