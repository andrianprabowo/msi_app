import 'dart:convert';

class EnterGl {
  String enterGl;
  EnterGl({
    this.enterGl,
  });

  EnterGl copyWith({
    String enterGl,
  }) {
    return EnterGl(
      enterGl: enterGl ?? this.enterGl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enterGl': enterGl,
    };
  }

  factory EnterGl.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return EnterGl(
      enterGl: map['gisequenceNo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EnterGl.fromJson(String source) => EnterGl.fromMap(json.decode(source));

  @override
  String toString() => 'EnterGl(enterGl: $enterGl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is EnterGl &&
      o.enterGl == enterGl;
  }

  @override
  int get hashCode => enterGl.hashCode;
  }
