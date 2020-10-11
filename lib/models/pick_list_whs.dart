import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';

class PickListWhs with ChangeNotifier {
  final String pickNumber;
  final DateTime pickDate;
  final String cardCode;
  final String cardName;
  final String pickRemark;
  List<PickItemReceive> pickItemList;
  PickListWhs({
    this.pickNumber,
    this.pickDate,
    this.cardCode,
    this.cardName,
    this.pickRemark,
    this.pickItemList,
  });

  PickListWhs copyWith({
    String pickNumber,
    DateTime pickDate,
    String cardCode,
    String cardName,
    String pickRemark,
    List<PickItemReceive> pickItemList,
  }) {
    return PickListWhs(
      pickNumber: pickNumber ?? this.pickNumber,
      pickDate: pickDate ?? this.pickDate,
      cardCode: cardCode ?? this.cardCode,
      cardName: cardName ?? this.cardName,
      pickRemark: pickRemark ?? this.pickRemark,
      pickItemList: pickItemList ?? this.pickItemList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickNumber': pickNumber,
      'pickDate': pickDate?.millisecondsSinceEpoch,
      'cardCode': cardCode,
      'cardName': cardName,
      'pickRemark': pickRemark,
      'pickItemList': pickItemList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PickListWhs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickListWhs(
      pickNumber: map['uDocNum'] ?? '',
      pickDate: DateTime.parse(map['docDate']),
      cardCode: map['cardCode'] ?? '',
      cardName: map['cardName'] ?? '',
      pickRemark: map['pickRemark'] ?? "",
      pickItemList: map['pickItemList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PickListWhs.fromJson(String source) =>
      PickListWhs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickListWhs(pickNumber: $pickNumber, pickDate: $pickDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark, pickItemList: $pickItemList)';
  }
}
