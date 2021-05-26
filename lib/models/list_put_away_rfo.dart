import 'dart:convert';

import 'package:flutter/material.dart';

class ListPutAwayRfo with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final int idPwyrtoHeader;
  final String logMessage;
  ListPutAwayRfo({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.idPwyrtoHeader,
    this.logMessage,
  });

  ListPutAwayRfo copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListPutAwayRfo(
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
      'idPwyrtoHeader': idPwyrtoHeader,
      'logMessage': logMessage,
    };
  }

  factory ListPutAwayRfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPutAwayRfo(
      grpono: map['putAwayNo'] ?? '',
      poNo: map['doNo'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      idPwyrtoHeader: map['idPwyrtoHeader'] ?? 3,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPutAwayRfo.fromJson(String source) =>
      ListPutAwayRfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPutAwayRfo(grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListPutAwayRfo &&
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
