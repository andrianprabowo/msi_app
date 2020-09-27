import 'dart:convert';

class Item {
  final String itemCode;
  final String itemName;
  final double totalReceipt;
  final double receiptQty;
  final double remainingQty;
  final String uom;
  Item({
    this.itemCode,
    this.itemName,
    this.totalReceipt,
    this.receiptQty,
    this.remainingQty,
    this.uom,
  });

  Item copyWith({
    String itemCode,
    String itemName,
    double totalReceipt,
    double receiptQty,
    double remainingQty,
    String uom,
  }) {
    return Item(
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      totalReceipt: totalReceipt ?? this.totalReceipt,
      receiptQty: receiptQty ?? this.receiptQty,
      remainingQty: remainingQty ?? this.remainingQty,
      uom: uom ?? this.uom,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'itemName': itemName,
      'totalReceipt': totalReceipt,
      'receiptQty': receiptQty,
      'remainingQty': remainingQty,
      'uom': uom,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Item(
      itemCode: map['itemCode'],
      itemName: map['itemName'],
      totalReceipt: map['totalReceipt'],
      receiptQty: map['receiptQty'],
      remainingQty: map['remainingQty'],
      uom: map['uom'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(itemCode: $itemCode, itemName: $itemName, totalReceipt: $totalReceipt, receiptQty: $receiptQty, remainingQty: $remainingQty, uom: $uom)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Item &&
        o.itemCode == itemCode &&
        o.itemName == itemName &&
        o.totalReceipt == totalReceipt &&
        o.receiptQty == receiptQty &&
        o.remainingQty == remainingQty &&
        o.uom == uom;
  }

  @override
  int get hashCode {
    return itemCode.hashCode ^
        itemName.hashCode ^
        totalReceipt.hashCode ^
        receiptQty.hashCode ^
        remainingQty.hashCode ^
        uom.hashCode;
  }
}
