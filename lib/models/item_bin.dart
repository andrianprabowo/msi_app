import 'dart:convert';

class ItemBin {
  final String itemCode;
  final String itemName;
  ItemBin({
    this.itemCode,
    this.itemName,
  });

  ItemBin copyWith({
    String itemCode,
    String itemName,
  }) {
    return ItemBin(
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'itemName': itemName,
    };
  }

  factory ItemBin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemBin(
      itemCode: map['itemCode'] ?? '',
      itemName: map['itemName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemBin.fromJson(String source) =>
      ItemBin.fromMap(json.decode(source));

  @override
  String toString() => 'ItemBin(itemCode: $itemCode, itemName: $itemName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemBin && o.itemCode == itemCode && o.itemName == itemName;
  }

  @override
  int get hashCode => itemCode.hashCode ^ itemName.hashCode;
}
