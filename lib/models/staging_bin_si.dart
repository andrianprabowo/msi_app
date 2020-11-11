import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_si.dart';

class StagingBinSi with ChangeNotifier {
  final String binCode;
  final DateTime docDate;
  String plant;
  String plantName;
  final String fileName;
  List<ItemBinSi> itemBinList;
  StagingBinSi({
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

  factory StagingBinSi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StagingBinSi(
      binCode: map['binCode'] ?? '',
      plant: map['plant'] ?? '',
      plantName: map['plantName'] ?? '',
      fileName: map['fileName'] ?? '',
      itemBinList: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StagingBinSi.fromJson(String source) =>
      StagingBinSi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StagingBinSi(binCode: $binCode, docDate: $docDate, plant: $plant, plantName: $plantName, fileName: $fileName, itemBinList: $itemBinList)';
  }
}
