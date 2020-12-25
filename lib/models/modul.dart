import 'dart:convert';

import 'package:flutter/material.dart';

class Modul with ChangeNotifier {
  final String permName;
  Modul({
    this.permName,
  });
 

  Modul copyWith({
    String permName,
  }) {
    return Modul(
      permName: permName ?? this.permName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'permName': permName,
    };
  }

  factory Modul.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Modul(
      permName: map['permName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Modul.fromJson(String source) => Modul.fromMap(json.decode(source));

  @override
  String toString() => 'Modul(permName: $permName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Modul &&
      o.permName == permName;
  }

  @override
  int get hashCode => permName.hashCode;
}
