import 'dart:convert';

class StagingBin {
  final String binCode;
  final String warehouse;
  StagingBin({
    this.binCode,
    this.warehouse,
  });

  StagingBin copyWith({
    String binCode,
    String warehouse,
  }) {
    return StagingBin(
      binCode: binCode ?? this.binCode,
      warehouse: warehouse ?? this.warehouse,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'binCode': binCode,
      'warehouse': warehouse,
    };
  }

  factory StagingBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StagingBin(
      binCode: map['binCode'] ?? '',
      warehouse: map['warehouse'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StagingBin.fromJson(String source) =>
      StagingBin.fromMap(json.decode(source));

  @override
  String toString() => 'StagingBin(binCode: $binCode, warehouse: $warehouse)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StagingBin && o.binCode == binCode && o.warehouse == warehouse;
  }

  @override
  int get hashCode => binCode.hashCode ^ warehouse.hashCode;
}
