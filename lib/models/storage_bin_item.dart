import 'dart:convert';

import 'package:flutter/material.dart';

class StorageBinItem with ChangeNotifier {
  final String binCode;
  final String whsCode;
  StorageBinItem({
    this.binCode,
    this.whsCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'binCode': binCode,
      'whsCode': whsCode,
    };
  }

  factory StorageBinItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StorageBinItem(
      binCode: map['binCode'] ?? '',
      whsCode: map['whsCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StorageBinItem.fromJson(String source) =>
      StorageBinItem.fromMap(json.decode(source));

  @override
  String toString() => 'StorageBinItem(binCode: $binCode, whsCode: $whsCode)';
}
