import 'dart:convert';

class MenuModul {
  final String permName;
  final String authorized;
  final String username;
  MenuModul({
    this.permName,
    this.authorized,
    this.username,
  });

 

  Map<String, dynamic> toMap() {
    return {
      'permName': permName,
      'authorized': authorized,
      'username': username,
    };
  }

  factory MenuModul.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MenuModul(
      permName: map['permName'] ?? '',
      authorized: map['authorized'] ?? '',
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModul.fromJson(String source) =>
      MenuModul.fromMap(json.decode(source));

  @override
  String toString() =>
      'MenuModul(permName: $permName, authorized: $authorized, username: $username ';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MenuModul &&
        o.permName == permName &&
        o.authorized == authorized &&
        o.username == username;
  }

  @override
  int get hashCode => permName.hashCode ^ authorized.hashCode ^ username.hashCode;
}
