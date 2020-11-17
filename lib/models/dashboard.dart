import 'dart:convert';

import 'package:flutter/material.dart';

class Dashboard with ChangeNotifier {
  final String module;
  final String whsCode;
  final int count;
  Dashboard({
    this.module,
    this.whsCode,
    this.count,
  });

  Dashboard copyWith({
    String module,
    String whsCode,
    int count,
  }) {
    return Dashboard(
      module: module ?? this.module,
      whsCode: whsCode ?? this.whsCode,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'module': module,
      'whsCode': whsCode,
      'count': count,
    };
  }

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Dashboard(
      module: map['module'] ?? '',
      whsCode: map['whsCode'] ?? '',
      count: map['count'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dashboard.fromJson(String source) => Dashboard.fromMap(json.decode(source));

  @override
  String toString() => 'Dashboard(module: $module, whsCode: $whsCode, count: $count)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Dashboard &&
      o.module == module &&
      o.whsCode == whsCode &&
      o.count == count;
  }

  @override
  int get hashCode => module.hashCode ^ whsCode.hashCode ^ count.hashCode;
}
