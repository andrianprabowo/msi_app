import 'dart:convert';

class Warehouse {
  final String whsCode;
  final String whsName;
  final String username;
  Warehouse({
    this.whsCode,
    this.whsName,
    this.username,
  });

  Warehouse copyWith({
    String whsCode,
    String whsName,
    String username,
  }) {
    return Warehouse(
      whsCode: whsCode ?? this.whsCode,
      whsName: whsName ?? this.whsName,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'whsCode': whsCode,
      'whsName': whsName,
      'username': username,
    };
  }

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Warehouse(
      whsCode: map['outlet'] ?? '',
      whsName: map['outletName1'] ?? '',
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Warehouse.fromJson(String source) =>
      Warehouse.fromMap(json.decode(source));

  @override
  String toString() =>
      'Warehouse(whsCode: $whsCode, whsName: $whsName, username: $username)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Warehouse &&
        o.whsCode == whsCode &&
        o.whsName == whsName &&
        o.username == username;
  }

  @override
  int get hashCode => whsCode.hashCode ^ whsName.hashCode ^ username.hashCode;
}
