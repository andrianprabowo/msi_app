import 'dart:convert';

class Warehouse {
  final String whsCode;
  final String whsName;
  Warehouse({
    this.whsCode,
    this.whsName,
  });

  Warehouse copyWith({
    String whsCode,
    String whsName,
  }) {
    return Warehouse(
      whsCode: whsCode ?? this.whsCode,
      whsName: whsName ?? this.whsName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'whsCode': whsCode,
      'whsName': whsName,
    };
  }

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Warehouse(
      whsCode: map['whsCode'] ?? '',
      whsName: map['whsName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Warehouse.fromJson(String source) =>
      Warehouse.fromMap(json.decode(source));

  @override
  String toString() => 'Warehouse(whsCode: $whsCode, whsName: $whsName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Warehouse && o.whsCode == whsCode && o.whsName == whsName;
  }

  @override
  int get hashCode => whsCode.hashCode ^ whsName.hashCode;
}
