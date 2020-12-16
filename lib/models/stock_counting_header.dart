import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_item.dart';

class StockCountingHeader with ChangeNotifier {
  final String pickNumber;
  final DateTime pickDate;
  final DateTime postingDate;
  String cardCode;
  final String cardName;
  String whs;
  String user;
  final String pickRemark;
  final String filename;
  String storageLocation;
  List<StockCountingItem> pickItemList;
  StockCountingHeader({
    this.pickNumber,
    this.pickDate,
    this.postingDate,
    this.cardCode,
    this.cardName,
    this.whs,
    this.user,
    this.pickRemark,
    this.filename,
    this.storageLocation,
    this.pickItemList,
  });

  Map<String, dynamic> toMap() {
    return {
      'stckcntingNo': pickNumber,
      'deliveryDate': pickDate?.toIso8601String(),
      'postingDate': DateTime.now().toIso8601String(),
      'createdDate': DateTime.now().toIso8601String(),
      'plant': whs,
      'plantName': user,
      'remark': pickRemark,
      'filename': 'Stock COunting',
      // 'storageLocation': storageLocation,
      'details': pickItemList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StockCountingHeader.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StockCountingHeader(
      pickNumber: map['uDocNum'] ?? '',
      pickDate: DateTime.parse(map['docDate']),
      cardCode: map['cardCode'] ?? '',
      cardName: map['cardName'] ?? '',
      pickRemark: map['pickRemark'] ?? '',
      filename: 'Stock Counting',
      storageLocation: map['storageLocation'] ?? '',
      pickItemList: map['pickItemList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingHeader.fromJson(String source) =>
      StockCountingHeader.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockCountingHeader(pickNumber: $pickNumber, pickDate: $pickDate, postingDate: $postingDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark, filename: $filename, storageLocation: $storageLocation, pickItemList: $pickItemList)';
  }
}
