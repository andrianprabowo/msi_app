import 'dart:convert';

class Warehouse {
  final String whsCode;
  final String whsName;
  final String username;
  final int adminId;
  final int decLen;
  final String decString;
  Warehouse({
    this.whsCode,
    this.whsName,
    this.username,
    this.adminId,
    this.decLen,
    this.decString,
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
      'idUserInput': adminId,
      'decLen': decLen,
      'decString': decString,
    };
  }

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Warehouse(
      whsCode: map['outlet'] ?? '',
      whsName: map['outletName1'] ?? '',
      username: map['username'] ?? '',
      adminId: map['adminId'] ?? 0.0,
      decLen: map['decLen'] ?? 7,
      decString: map['decString'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Warehouse.fromJson(String source) =>
      Warehouse.fromMap(json.decode(source));

  @override
  String toString() =>
      'Warehouse(whsCode: $whsCode, whsName: $whsName, username: $username ,adminId: $adminId,decLen: $decLen,decString: $decString)';

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
