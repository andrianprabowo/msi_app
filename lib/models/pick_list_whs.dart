import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';

class PickListWhs with ChangeNotifier {
  final String pickNumber;
  final DateTime pickDate;
  final DateTime postingDate;
  final String cardCode;
  final String cardName;
  final String pickRemark;
  final String filename;
  String storageLocation;
  List<PickItemReceive> pickItemList;
  PickListWhs({
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
      'postingDate': DateTime.now().toIso8601String(),
      'plant': cardCode,
      'plantName': cardName,
      'remark': pickRemark,
      'filename': 'Pick List',
      'storageLocation': storageLocation,
      'details': pickItemList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PickListWhs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickListWhs(
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

  factory PickListWhs.fromJson(String source) =>
      PickListWhs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickListWhs(pickNumber: $pickNumber, pickDate: $pickDate, postingDate: $postingDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark, filename: $filename, storageLocation: $storageLocation, pickItemList: $pickItemList)';
  }
}
