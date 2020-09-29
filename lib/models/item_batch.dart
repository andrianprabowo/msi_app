import 'dart:convert';

class ItemBatch {
  final String batchNumber;
  final String description;
  final double availableQty;
  final String inventoryUom;
  ItemBatch({
    this.batchNumber,
    this.description,
    this.availableQty,
    this.inventoryUom,
  });

  ItemBatch copyWith({
    String batchNumber,
    String description,
    double availableQty,
    String inventoryUom,
  }) {
    return ItemBatch(
      batchNumber: batchNumber ?? this.batchNumber,
      description: description ?? this.description,
      availableQty: availableQty ?? this.availableQty,
      inventoryUom: inventoryUom ?? this.inventoryUom,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'batchNumber': batchNumber,
      'description': description,
      'availableQty': availableQty,
      'inventoryUom': inventoryUom,
    };
  }

  factory ItemBatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBatch(
      batchNumber: map['batchNumber'],
      description: map['description'],
      availableQty: map['availableQty'],
      inventoryUom: map['inventoryUom'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBatch.fromJson(String source) =>
      ItemBatch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemBatch(batchNumber: $batchNumber, description: $description, availableQty: $availableQty, inventoryUom: $inventoryUom)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemBatch &&
        o.batchNumber == batchNumber &&
        o.description == description &&
        o.availableQty == availableQty &&
        o.inventoryUom == inventoryUom;
  }

  @override
  int get hashCode {
    return batchNumber.hashCode ^
        description.hashCode ^
        availableQty.hashCode ^
        inventoryUom.hashCode;
  }
}
