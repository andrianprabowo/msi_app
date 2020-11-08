import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';


class StockCountingBin with ChangeNotifier {
  final String binCode;
  List<ItemBin> itemBinList;
  StockCountingBin({
    this.binCode,
    this.itemBinList,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'binCode': binCode,
      'itemBinList': itemBinList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StockCountingBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return StockCountingBin(
      binCode: map['binCode'] ?? '',
      itemBinList: map['itemBinList'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCountingBin.fromJson(String source) => StockCountingBin.fromMap(json.decode(source));

  @override
  String toString() => 'StockCountingBin(binCode: $binCode, itemBinList: $itemBinList)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is StockCountingBin &&
      o.binCode == binCode &&
      listEquals(o.itemBinList, itemBinList);
  }

  @override
  int get hashCode => binCode.hashCode ^ itemBinList.hashCode;
}
