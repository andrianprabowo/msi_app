import 'dart:convert';

class ListGoodReceiptPo {
  final String grpoNumber;
  final String poNumber;
  final DateTime docDate;
  final String vendor;
  final String status;
  ListGoodReceiptPo({
    this.grpoNumber,
    this.poNumber,
    this.docDate,
    this.vendor,
    this.status,
  });

  ListGoodReceiptPo copyWith({
    String grpoNumber,
    String poNumber,
    DateTime docDate,
    String vendor,
    String status,
  }) {
    return ListGoodReceiptPo(
      grpoNumber: grpoNumber ?? this.grpoNumber,
      poNumber: poNumber ?? this.poNumber,
      docDate: docDate ?? this.docDate,
      vendor: vendor ?? this.vendor,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'grpoNumber': grpoNumber,
      'poNumber': poNumber,
      'docDate': docDate?.toIso8601String(),
      'vendor': vendor,
      'status': status,
    };
  }

  factory ListGoodReceiptPo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListGoodReceiptPo(
      grpoNumber: map['grpoNumber'] ?? '',
      poNumber: map['poNumber'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListGoodReceiptPo.fromJson(String source) =>
      ListGoodReceiptPo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListGoodReceiptPo(grpoNumber: $grpoNumber, poNumber: $poNumber, docDate: $docDate, vendor: $vendor, status: $status)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListGoodReceiptPo &&
        o.grpoNumber == grpoNumber &&
        o.poNumber == poNumber &&
        o.docDate == docDate &&
        o.vendor == vendor &&
        o.status == status;
  }

  @override
  int get hashCode {
    return grpoNumber.hashCode ^
        poNumber.hashCode ^
        docDate.hashCode ^
        vendor.hashCode ^
        status.hashCode;
  }
}
