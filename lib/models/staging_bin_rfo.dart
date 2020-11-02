import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_rfo.dart';

class StagingBinRfo with ChangeNotifier {
  final String binCode;
  final DateTime docDate;
  String plant;
  String plantName;
  final String fileName;
  List<ItemBinRfo> itemBinList;
  StagingBinRfo({
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

  factory StagingBinRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StagingBinRfo(
      binCode: map['binCode'] ?? '',
      plant: map['plant'] ?? '',
      plantName: map['plantName'] ?? '',
      fileName: map['fileName'] ?? '',
      itemBinList: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StagingBinRfo.fromJson(String source) =>
      StagingBinRfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StagingBinRfo(binCode: $binCode, docDate: $docDate, plant: $plant, plantName: $plantName, fileName: $fileName, itemBinList: $itemBinList)';
  }
}
