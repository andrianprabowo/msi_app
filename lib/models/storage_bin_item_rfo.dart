import 'dart:convert';

import 'package:flutter/material.dart';

class StorageBinItemRfo with ChangeNotifier {
  final String binCode;
  final String whsCode;
  StorageBinItemRfo({
    this.binCode,
    this.whsCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'binCode': binCode,
      'whsCode': whsCode,
    };
  }

  factory StorageBinItemRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StorageBinItemRfo(
      binCode: map['binCode'] ?? '',
      whsCode: map['whsCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StorageBinItemRfo.fromJson(String source) =>
      StorageBinItemRfo.fromMap(json.decode(source));

  @override
  String toString() => 'StorageBinItemRfo(binCode: $binCode, whsCode: $whsCode)';
}
