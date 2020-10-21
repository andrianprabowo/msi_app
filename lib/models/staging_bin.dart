import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';

class StagingBin with ChangeNotifier {
  final String binCode;
  final DateTime docDate;
  String plant;
  String plantName;
  final String fileName;
  List<ItemBin> itemBinList;
  StagingBin({
    this.binCode,
    this.docDate,
    this.plant,
    this.plantName,
    this.fileName,
    this.itemBinList,
  });

  Map<String, dynamic> toMap() {
    return {
      'storageLocation': binCode,
      'postingDate': DateTime.now().toIso8601String(),
      'plant': plant,
      'plantName': plantName,
      'filename': 'Put Away',
      'details': itemBinList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StagingBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StagingBin(
      binCode: map['binCode'] ?? '',
      plant: map['plant'] ?? '',
      plantName: map['plantName'] ?? '',
      fileName: map['fileName'] ?? '',
      itemBinList: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StagingBin.fromJson(String source) =>
      StagingBin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StagingBin(binCode: $binCode, docDate: $docDate, plant: $plant, plantName: $plantName, fileName: $fileName, itemBinList: $itemBinList)';
  }
}
