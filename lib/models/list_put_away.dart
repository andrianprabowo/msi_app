import 'dart:convert';

import 'package:flutter/material.dart';

class ListPutAway with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final String logMessage;
  ListPutAway({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.logMessage,
  });

  ListPutAway copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListPutAway(
      grpono: grpono ?? this.grpono,
      poNo: poNo ?? this.poNo,
      docDate: docDate ?? this.docDate,
      vendor: vendor ?? this.vendor,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'putAwayNo': grpono,
      'doNo': poNo,
      'docDate': docDate?.toIso8601String(),
      'vendor': vendor,
      'status': status,
      'logMessage': logMessage,
    };
  }

  factory ListPutAway.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPutAway(
      grpono: map['putAwayNo'] ?? '',
      poNo: map['doNo'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPutAway.fromJson(String source) =>
      ListPutAway.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPutAway(grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListPutAway &&
        o.grpono == grpono &&
        o.poNo == poNo &&
        o.docDate == docDate &&
        o.vendor == vendor &&
        o.status == status;
  }

  @override
  int get hashCode {
    return grpono.hashCode ^
        poNo.hashCode ^
        docDate.hashCode ^
        vendor.hashCode ^
        status.hashCode;
  }
}
