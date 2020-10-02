import 'dart:convert';

class PickItemReceive {
  final String itemCode;
  final String dscription;
  final double openQty;
  final double quantity;
  final String unitMsr;
  PickItemReceive({
    this.itemCode,
    this.dscription,
    this.openQty,
    this.quantity,
    this.unitMsr,
  });

  PickItemReceive copyWith({
    String itemCode,
    String dscription,
    double openQty,
    double quantity,
    String unitMsr,
  }) {
    return PickItemReceive(
      itemCode: itemCode ?? this.itemCode,
      dscription: dscription ?? this.dscription,
      openQty: openQty ?? this.openQty,
      quantity: quantity ?? this.quantity,
      unitMsr: unitMsr ?? this.unitMsr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'dscription': dscription,
      'openQty': openQty,
      'quantity': quantity,
      'unitMsr': unitMsr,
    };
  }

  factory PickItemReceive.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickItemReceive(
      itemCode: map['itemCode'] ?? '',
      dscription: map['dscription'] ?? '',
      openQty: map['openQty'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      unitMsr: map['unitMsr'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PickItemReceive.fromJson(String source) =>
      PickItemReceive.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickItemReceive(itemCode: $itemCode, dscription: $dscription, openQty: $openQty, quantity: $quantity, unitMsr: $unitMsr)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PickItemReceive &&
        o.itemCode == itemCode &&
        o.dscription == dscription &&
        o.openQty == openQty &&
        o.quantity == quantity &&
        o.unitMsr == unitMsr;
  }

  @override
  int get hashCode {
    return itemCode.hashCode ^
        dscription.hashCode ^
        openQty.hashCode ^
        quantity.hashCode ^
        unitMsr.hashCode;
  }
}
