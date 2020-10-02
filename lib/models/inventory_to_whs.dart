import 'dart:convert';

class InventoryToWhs {
  final String docNumber;
  final DateTime docDate;
  final String outlet;
  final String memo;
  InventoryToWhs({
    this.docNumber,
    this.docDate,
    this.outlet,
    this.memo,
  });

  InventoryToWhs copyWith({
    String docNumber,
    DateTime docDate,
    String outlet,
    String memo,
  }) {
    return InventoryToWhs(
      docNumber: docNumber ?? this.docNumber,
      docDate: docDate ?? this.docDate,
      outlet: outlet ?? this.outlet,
      memo: memo ?? this.memo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docNumber': docNumber,
      'docDate': docDate?.toIso8601String(),
      'outlet': outlet,
      'memo': memo,
    };
  }

  factory InventoryToWhs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryToWhs(
      docNumber: map['docNumber'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      outlet: map['outlet'] ?? '',
      memo: map['memo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryToWhs.fromJson(String source) =>
      InventoryToWhs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryToWhs(docNumber: $docNumber, docDate: $docDate, outlet: $outlet, memo: $memo)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is InventoryToWhs &&
        o.docNumber == docNumber &&
        o.docDate == docDate &&
        o.outlet == outlet &&
        o.memo == memo;
  }

  @override
  int get hashCode {
    return docNumber.hashCode ^
        docDate.hashCode ^
        outlet.hashCode ^
        memo.hashCode;
  }
}
