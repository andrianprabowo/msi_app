import 'dart:convert';

import 'package:flutter/material.dart';

class ListInvDispatchRtv with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final String logMessage;
  final int idRvidpHeader;
  
  ListInvDispatchRtv({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.logMessage,
    this.idRvidpHeader,
  });

  ListInvDispatchRtv copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListInvDispatchRtv(
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
      'idRvidpHeader': idRvidpHeader,
    };
  }

  factory ListInvDispatchRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListInvDispatchRtv(
      grpono: map['pickListNo'] ?? '',
      poNo: map['returnNo'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      logMessage: map['logMessage'] ?? '',
      idRvidpHeader: map['idRvidpHeader'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListInvDispatchRtv.fromJson(String source) =>
      ListInvDispatchRtv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListInvDispatchRtv(grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListInvDispatchRtv &&
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
