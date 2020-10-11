import 'dart:convert';

class InventoryDispatchHeader {
  final String docNumber;
  final DateTime requireDate;
  final String toWarehouse;
  final String memo;
  InventoryDispatchHeader({
    this.docNumber,
    this.requireDate,
    this.toWarehouse,
    this.memo,
  });

  InventoryDispatchHeader copyWith({
    String docNumber,
    DateTime requireDate,
    String toWarehouse,
    String memo,
  }) {
    return InventoryDispatchHeader(
      docNumber: docNumber ?? this.docNumber,
      requireDate: requireDate ?? this.requireDate,
      toWarehouse: toWarehouse ?? this.toWarehouse,
      memo: memo ?? this.memo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docNumber': docNumber,
      'requireDate': requireDate?.toIso8601String(),
      'toWarehouse': toWarehouse,
      'memo': memo,
    };
  }

  factory InventoryDispatchHeader.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchHeader(
      docNumber: map['docNumber'] ?? '',
      requireDate: DateTime.parse(map['requireDate']),
      toWarehouse: map['toWarehouse'] ?? '',
      memo: map['memo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchHeader.fromJson(String source) =>
      InventoryDispatchHeader.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchHeader(docNumber: $docNumber, requireDate: $requireDate, toWarehouse: $toWarehouse, memo: $memo)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is InventoryDispatchHeader &&
        o.docNumber == docNumber &&
        o.requireDate == requireDate &&
        o.toWarehouse == toWarehouse &&
        o.memo == memo;
  }

  @override
  int get hashCode {
    return docNumber.hashCode ^
        requireDate.hashCode ^
        toWarehouse.hashCode ^
        memo.hashCode;
  }
}
