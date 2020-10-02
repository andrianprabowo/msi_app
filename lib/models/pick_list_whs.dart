import 'dart:convert';

class PickListWhs {
  final String pickNumber;
  final DateTime pickDate;
  final String cardCode;
  final String cardName;
  final String pickRemark;
  PickListWhs({
    this.pickNumber,
    this.pickDate,
    this.cardCode,
    this.cardName,
    this.pickRemark,
  });

  PickListWhs copyWith({
    String pickNumber,
    DateTime pickDate,
    String cardCode,
    String cardName,
    String pickRemark,
  }) {
    return PickListWhs(
      pickNumber: pickNumber ?? this.pickNumber,
      pickDate: pickDate ?? this.pickDate,
      cardCode: cardCode ?? this.cardCode,
      cardName: cardName ?? this.cardName,
      pickRemark: pickRemark ?? this.pickRemark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uDocNum': pickNumber,
      'docDate': pickDate?.toIso8601String(),
      'cardCode': cardCode,
      'cardName': cardName,
      'pickRemark': pickRemark,
    };
  }

  factory PickListWhs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PickListWhs(
      pickNumber: map['uDocNum'] ?? '',
      pickDate: DateTime.parse(map['docDate']),
      cardCode: map['cardCode'] ?? '',
      cardName: map['cardName'] ?? '',
      pickRemark: map['pickRemark'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PickListWhs.fromJson(String source) =>
      PickListWhs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickListWhs(pickNumber: $pickNumber, pickDate: $pickDate, cardCode: $cardCode, cardName: $cardName, pickRemark: $pickRemark)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PickListWhs &&
        o.pickNumber == pickNumber &&
        o.pickDate == pickDate &&
        o.cardCode == cardCode &&
        o.cardName == cardName &&
        o.pickRemark == pickRemark;
  }

  @override
  int get hashCode {
    return pickNumber.hashCode ^
        pickDate.hashCode ^
        cardCode.hashCode ^
        cardName.hashCode ^
        pickRemark.hashCode;
  }
}
