import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/models/stock_counting_item.dart';

class StockCountingHeader with ChangeNotifier {
  final int docEntry;
  final DateTime postingDate;
  final String poNumber;
  final DateTime docDate;
  final String vendorCode;
  final String vendorName;
  String plant;
  String storageLocation;
  String storageLocationName;
  final String docnum;
  List<StockCountingItem> detailList;
  StockCountingHeader({
    this.docEntry,
    this.postingDate,
    this.poNumber,
    this.docDate,
    this.vendorCode,
    this.vendorName,
    this.plant,
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
      'fileName': 'GRPO MOBILE',
      'plant': plant ?? '',
      'storageLocation': storageLocation ?? '',
      'storageLocationName': storageLocationName ?? '',
      'docnum': poNumber,
      'details': detailList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StockCountingHeader.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StockCountingHeader(
      docEntry: map['h_DocEntry'] ?? 0,
      poNumber: map['uDocNum'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendorCode: map['cardCode'] ?? '',
      vendorName: map['cardName'] ?? '',
      detailList: map['detailsList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingHeader.fromJson(String source) =>
      StockCountingHeader.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockCountingHeader(docEntry: $docEntry, poNumber: $poNumber, docDate: $docDate, vendorCode: $vendorCode, vendorName: $vendorName, plant: $plant ,detailList: $detailList)';
  }
}
