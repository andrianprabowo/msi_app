import 'dart:convert';

class BinRtv {
  String binCode;
  String binName;
  BinRtv({
    this.binCode,
    this.binName,
  });

  BinRtv copyWith({
    String binCode,
    String binName,
  }) {
    return BinRtv(
      binCode: binCode ?? this.binCode,
      binName: binName ?? this.binName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'binCode': binCode,
      'binName': binName,
    };
  }

  factory BinRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return BinRtv(
      binCode: map['binCode'] ?? '',
      binName: map['binName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BinRtv.fromJson(String source) => BinRtv.fromMap(json.decode(source));

  @override
  String toString() => 'BinRtv(binCode: $binCode, binName: $binName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is BinRtv &&
      o.binCode == binCode &&
      o.binName == binName;
  }

  @override
  int get hashCode => binCode.hashCode ^ binName.hashCode;
}
