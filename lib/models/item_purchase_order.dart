import 'dart:convert';

class ItemPurchaseOrder {
  final String itemCode;
  final String itemName;
  final double totalReceipt;
  final double receiptQty;
  final double remainingQty;
  final String uom;
  final String cardCode;
  ItemPurchaseOrder({
    this.itemCode,
    this.itemName,
    this.totalReceipt,
    this.receiptQty,
    this.remainingQty,
    this.uom,
    this.cardCode,
  });

  ItemPurchaseOrder copyWith({
    String itemCode,
    String itemName,
    double totalReceipt,
    double receiptQty,
    double remainingQty,
    String uom,
    String cardCode,
  }) {
    return ItemPurchaseOrder(
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      totalReceipt: totalReceipt ?? this.totalReceipt,
      receiptQty: receiptQty ?? this.receiptQty,
      remainingQty: remainingQty ?? this.remainingQty,
      uom: uom ?? this.uom,
      cardCode: cardCode ?? this.cardCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'det_ItemCode': itemCode,
      'det_Deskripsi': itemName,
      'det_OpenQty': totalReceipt,
      'det_Qty': receiptQty,
      'remainingQty': remainingQty,
      'det_UnitMsr': uom,
      'h_CardCode': cardCode,
    };
  }

  factory ItemPurchaseOrder.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ItemPurchaseOrder(
      itemCode: map['det_ItemCode'] ?? '',
      itemName: map['det_Deskripsi'] ?? '',
      totalReceipt: map['totalReceipt'] ?? 0.0,
      receiptQty: map['det_Qty'] ?? 0.0,
      remainingQty: map['det_OpenQty'] ?? 0.0,
      uom: map['det_UnitMsr'] ?? '',
      cardCode: map['h_CardCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemPurchaseOrder.fromJson(String source) =>
      ItemPurchaseOrder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemPurchaseOrder(itemCode: $itemCode, itemName: $itemName, totalReceipt: $totalReceipt, receiptQty: $receiptQty, remainingQty: $remainingQty, uom: $uom, cardCode: $cardCode)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemPurchaseOrder &&
        o.itemCode == itemCode &&
        o.itemName == itemName &&
        o.totalReceipt == totalReceipt &&
        o.receiptQty == receiptQty &&
        o.remainingQty == remainingQty &&
        o.uom == uom &&
        o.cardCode == cardCode;
  }

  @override
  int get hashCode {
    return itemCode.hashCode ^
        itemName.hashCode ^
        totalReceipt.hashCode ^
        receiptQty.hashCode ^
        remainingQty.hashCode ^
        uom.hashCode ^
        cardCode.hashCode;
  }
}
