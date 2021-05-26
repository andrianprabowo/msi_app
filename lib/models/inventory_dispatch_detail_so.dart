import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:msi_app/models/inventory_dispatch_item_so.dart';

class InventoryDispatchDetailSo with ChangeNotifier {
  final String docNumber;
  final DateTime docDate;
  final DateTime postingDate;
  String cardCode;
  final String cardName;
  final String pickRemark;
  final String filename;
  String storageLocation;
  String binSelect;

  List<InventoryDispatchItemSo> itemList;
  InventoryDispatchDetailSo({
    this.docNumber,
    this.docDate,
    this.postingDate,
    this.cardCode,
    this.cardName,
    this.pickRemark,
    this.filename,
    this.storageLocation,
    this.binSelect,
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
      'filename': 'Inventory Dispatch',
      'storageLocation': storageLocation,
      'binSelect': binSelect,
      'details': itemList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory InventoryDispatchDetailSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchDetailSo(
      docNumber: map['uDocNum'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      cardCode: map['cardCode'] ?? '',
      cardName: map['cardName'] ?? '',
      pickRemark: map['pickRemark'] ?? '',
      filename: 'Inventory Dispatch',
      storageLocation: map['storageLocation'],
      binSelect: map['binSelect']??'',
      itemList: map['itemList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchDetailSo.fromJson(String source) =>
      InventoryDispatchDetailSo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchDetailSo(docNumber: $docNumber, docDate: $docDate, postingDate: $postingDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark, filename: $filename, storageLocation: $storageLocation, itemList: $itemList)';
  }
}
