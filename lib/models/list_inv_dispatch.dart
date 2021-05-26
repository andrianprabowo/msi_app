import 'dart:convert';

import 'package:flutter/material.dart';

class ListInvDispatch with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final int idInvent;
  final String logMessage;
  ListInvDispatch({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.idInvent,
    this.logMessage,
  });

  ListInvDispatch copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListInvDispatch(
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
      'idInvent': idInvent,
    };
  }

  factory ListInvDispatch.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListInvDispatch(
      grpono: map['pickListNo'] ?? '',
      poNo: map['srno'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      idInvent: map['idGrpodlvHeader'] ?? 0,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListInvDispatch.fromJson(String source) =>
      ListInvDispatch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListInvDispatch(grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListInvDispatch &&
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
