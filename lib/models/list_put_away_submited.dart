import 'dart:convert';

class ListPutAwaySubmited {
  final String putAwayNumber;
  final String fromStgBin;
  final DateTime docDate;
  final String binner;
  final String status;
  ListPutAwaySubmited({
    this.putAwayNumber,
    this.fromStgBin,
    this.docDate,
    this.binner,
    this.status,
  });

  ListPutAwaySubmited copyWith({
    String putAwayNumber,
    String fromStgBin,
    DateTime docDate,
    String binner,
    String status,
  }) {
    return ListPutAwaySubmited(
      putAwayNumber: putAwayNumber ?? this.putAwayNumber,
      fromStgBin: fromStgBin ?? this.fromStgBin,
      docDate: docDate ?? this.docDate,
      binner: binner ?? this.binner,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'putAwayNumber': putAwayNumber,
      'fromStgBin': fromStgBin,
      'docDate': docDate?.toIso8601String(),
      'binner': binner,
      'status': status,
    };
  }

  factory ListPutAwaySubmited.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPutAwaySubmited(
      putAwayNumber: map['putAwayNumber'],
      fromStgBin: map['fromStgBin'],
      docDate: DateTime.parse(map['docDate']),
      binner: map['binner'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPutAwaySubmited.fromJson(String source) =>
      ListPutAwaySubmited.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPutAwaySubmited(putAwayNumber: $putAwayNumber, fromStgBin: $fromStgBin, docDate: $docDate, binner: $binner, status: $status)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListPutAwaySubmited &&
        o.putAwayNumber == putAwayNumber &&
        o.fromStgBin == fromStgBin &&
        o.docDate == docDate &&
        o.binner == binner &&
        o.status == status;
  }

  @override
  int get hashCode {
    return putAwayNumber.hashCode ^
        fromStgBin.hashCode ^
        docDate.hashCode ^
        binner.hashCode ^
        status.hashCode;
  }
}
