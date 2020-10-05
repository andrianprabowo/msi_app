import 'dart:convert';

import 'package:flutter/cupertino.dart';

class StagingBin with ChangeNotifier {
  final String binCode;
  StagingBin({
    this.binCode,
  });

  StagingBin copyWith({
    String binCode,
  }) {
    return StagingBin(
      binCode: binCode ?? this.binCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'binCode': binCode,
    };
  }

  factory StagingBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StagingBin(
      binCode: map['binCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StagingBin.fromJson(String source) =>
      StagingBin.fromMap(json.decode(source));

  @override
  String toString() => 'StagingBin(binCode: $binCode)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StagingBin && o.binCode == binCode;
  }

  @override
  int get hashCode => binCode.hashCode;
}
