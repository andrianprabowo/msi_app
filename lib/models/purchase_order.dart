import 'dart:convert';

class PurchaseOrder {
  final String poNumber;
  final DateTime docDate;
  final String vendor;
  final String warehouse;
  PurchaseOrder({
    this.poNumber,
    this.docDate,
    this.vendor,
    this.warehouse,
  });

  PurchaseOrder copyWith({
    String poNumber,
    DateTime docDate,
    String vendor,
    String warehouse,
  }) {
    return PurchaseOrder(
      poNumber: poNumber ?? this.poNumber,
      docDate: docDate ?? this.docDate,
      vendor: vendor ?? this.vendor,
      warehouse: warehouse ?? this.warehouse,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'poNumber': poNumber,
      'docDate': docDate?.millisecondsSinceEpoch,
      'vendor': vendor,
      'warehouse': warehouse,
    };
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PurchaseOrder(
      poNumber: map['poNumber'],
      docDate: DateTime.fromMillisecondsSinceEpoch(map['docDate']),
      vendor: map['vendor'],
      warehouse: map['warehouse'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseOrder.fromJson(String source) =>
      PurchaseOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurchaseOrder(poNumber: $poNumber, docDate: $docDate, vendor: $vendor, warehouse: $warehouse)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PurchaseOrder &&
        o.poNumber == poNumber &&
        o.docDate == docDate &&
        o.vendor == vendor &&
        o.warehouse == warehouse;
  }

  @override
  int get hashCode {
    return poNumber.hashCode ^
        docDate.hashCode ^
        vendor.hashCode ^
        warehouse.hashCode;
  }
}
