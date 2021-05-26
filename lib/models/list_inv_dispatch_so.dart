import 'dart:convert';

import 'package:flutter/material.dart';

class ListInvDispatchSo with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final int idInvent;
  final String logMessage;
  ListInvDispatchSo({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.idInvent,
    this.logMessage,
  });

  ListInvDispatchSo copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListInvDispatchSo(
      grpono: grpono ?? this.grpono,
      poNo: poNo ?? this.poNo,
      docDate: docDate ?? this.docDate,
      vendor: vendor ?? this.vendor,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickListNo': grpono,
      'sono': poNo,
      'docDate': docDate?.toIso8601String(),
      'vendor': vendor,
      'status': status,
      'idInvent': idInvent,
      'logMessage': logMessage,
    };
  }

  factory ListInvDispatchSo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListInvDispatchSo(
      grpono: map['pickListNo'] ?? '',
      poNo: map['sono'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      idInvent: map['idSoidpHeader'] ?? 0,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListInvDispatchSo.fromJson(String source) =>
      ListInvDispatchSo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListInvDispatchSo(grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListInvDispatchSo &&
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
