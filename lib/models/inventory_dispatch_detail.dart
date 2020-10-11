import 'dart:convert';

class InventoryDispatchDetail {
  final String itemCode;
  final String itemName;
  final double totalToPick;
  final double remainingQty;
  final String inventoryUom;
  final int batchNumber;
  InventoryDispatchDetail({
    this.itemCode,
    this.itemName,
    this.totalToPick,
    this.remainingQty,
    this.inventoryUom,
    this.batchNumber,
  });

  InventoryDispatchDetail copyWith({
    String itemCode,
    String itemName,
    double totalToPick,
    double remainingQty,
    String inventoryUom,
    int batchNumber,
  }) {
    return InventoryDispatchDetail(
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      totalToPick: totalToPick ?? this.totalToPick,
      remainingQty: remainingQty ?? this.remainingQty,
      inventoryUom: inventoryUom ?? this.inventoryUom,
      batchNumber: batchNumber ?? this.batchNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'itemName': itemName,
      'totalToPick': totalToPick,
      'remainingQty': remainingQty,
      'inventoryUom': inventoryUom,
      'batchNumber': batchNumber,
    };
  }

  factory InventoryDispatchDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryDispatchDetail(
      itemCode: map['itemCode'] ?? '',
      itemName: map['itemName'] ?? '',
      totalToPick: map['totalToPick'] ?? 0.0,
      remainingQty: map['remainingQty'] ?? 0.0,
      inventoryUom: map['inventoryUom'] ?? 0.0,
      batchNumber: map['batchNumber'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDispatchDetail.fromJson(String source) =>
      InventoryDispatchDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryDispatchDetail(itemCode: $itemCode, itemName: $itemName, totalToPick: $totalToPick, remainingQty: $remainingQty, inventoryUom: $inventoryUom, batchNumber: $batchNumber)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is InventoryDispatchDetail &&
        o.itemCode == itemCode &&
        o.itemName == itemName &&
        o.totalToPick == totalToPick &&
        o.remainingQty == remainingQty &&
        o.inventoryUom == inventoryUom &&
        o.batchNumber == batchNumber;
  }

  @override
  int get hashCode {
    return itemCode.hashCode ^
        itemName.hashCode ^
        totalToPick.hashCode ^
        remainingQty.hashCode ^
        inventoryUom.hashCode ^
        batchNumber.hashCode;
  }
}
