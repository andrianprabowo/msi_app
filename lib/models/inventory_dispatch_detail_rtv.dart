import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_item_rtv.dart';

class InventoryDispatchDetailRtv with ChangeNotifier {
  final String docNumber;
  final DateTime docDate;
  DateTime postingDate;
  String cardCode;
  final String cardName;
  final String pickRemark;
  final String filename;
  String storageLocation;

  List<InventoryDispatchItemRtv> itemList;
  InventoryDispatchDetailRtv({
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
      'postingDate': postingDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'plant': cardCode,
      'plantName': cardName,
      'remark': pickRemark,
      'filename': 'Inventory Dispatch',
      'storageLocation': storageLocation,
      'details': itemList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory InventoryDispatchDetailRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchDetailRtv(
      docNumber: map['uDocNum'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      // postingDate: DateTime.parse(map['postingDate']) ?? DateTime.now(),
      cardCode: map['cardCode'] ?? '',
      cardName: map['cardName'] ?? '',
      pickRemark: map['pickRemark'] ?? '',
      filename: 'Inventory Dispatch',
      storageLocation: map['storageLocation'],
      itemList: map['itemList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchDetailRtv.fromJson(String source) =>
      InventoryDispatchDetailRtv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchDetailRtv(docNumber: $docNumber, docDate: $docDate, postingDate: $postingDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark, filename: $filename, storageLocation: $storageLocation, itemList: $itemList)';
  }
}
