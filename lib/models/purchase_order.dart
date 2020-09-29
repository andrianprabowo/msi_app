import 'dart:convert';

class PurchaseOrder {
  final int docEntry;
  final String poNumber;
  final DateTime docDate;
  final String vendorCode;
  final String vendorName;
  PurchaseOrder({
    this.docEntry,
    this.poNumber,
    this.docDate,
    this.vendorCode,
    this.vendorName,
  });

  PurchaseOrder copyWith({
    int docEntry,
    String poNumber,
    DateTime docDate,
    String vendorCode,
    String vendorName,
  }) {
    return PurchaseOrder(
      docEntry: docEntry ?? this.docEntry,
      poNumber: poNumber ?? this.poNumber,
      docDate: docDate ?? this.docDate,
      vendorCode: vendorCode ?? this.vendorCode,
      vendorName: vendorName ?? this.vendorName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'h_DocEntry': docEntry,
      'h_U_DocNum': poNumber,
      'h_DocDate': docDate?.millisecondsSinceEpoch,
      'h_CardCode': vendorCode,
      'h_CardName': vendorName,
    };
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PurchaseOrder(
      docEntry: map['h_DocEntry'] ?? 0,
      poNumber: map['h_U_DocNum'] ?? '',
      docDate: DateTime.parse(map['h_DocDate']),
      vendorCode: map['h_CardCode'] ?? '',
      vendorName: map['h_CardName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseOrder.fromJson(String source) =>
      PurchaseOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurchaseOrder(docEntry: $docEntry, poNumber: $poNumber, docDate: $docDate, vendorCode: $vendorCode, vendorName: $vendorName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PurchaseOrder &&
        o.docEntry == docEntry &&
        o.poNumber == poNumber &&
        o.docDate == docDate &&
        o.vendorCode == vendorCode &&
        o.vendorName == vendorName;
  }

  @override
  int get hashCode {
    return docEntry.hashCode ^
        poNumber.hashCode ^
        docDate.hashCode ^
        vendorCode.hashCode ^
        vendorName.hashCode;
  }
}
