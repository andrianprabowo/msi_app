import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';

class StagingBin with ChangeNotifier {
  final String binCode;
  List<ItemBin> itemBinList;
  StagingBin({
    this.binCode,
    this.itemBinList,
  });

  Map<String, dynamic> toMap() {
    return {
      'storageLocation': binCode,
      'details': itemBinList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StagingBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StagingBin(
      binCode: map['binCode'] ?? '',
      itemBinList: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StagingBin.fromJson(String source) =>
      StagingBin.fromMap(json.decode(source));

  @override
  String toString() =>
      'StagingBin(binCode: $binCode, itemBinList: $itemBinList)';
}
