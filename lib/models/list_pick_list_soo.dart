import 'dart:convert';
import 'package:flutter/material.dart';
// 2
class ListPickListSoo with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final int idSoplHeader;
  final int picklistSapnumber;
  final String logMessage;
  ListPickListSoo({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.idSoplHeader,
    this.picklistSapnumber,
    this.logMessage,
  });

  ListPickListSoo copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListPickListSoo(
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
      'idSoplHeader': idSoplHeader,
      'logMessage': logMessage,
    };
  }

  factory ListPickListSoo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPickListSoo(
      grpono: map['pickListNo'] ?? '',
      poNo: map['sono'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      idSoplHeader: map['idSoplHeader'] ?? 0,
      picklistSapnumber: map['picklistSapnumber'] ?? 0,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPickListSoo.fromJson(String source) =>
      ListPickListSoo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPickListSoo(picklistSapnumber: $picklistSapnumber,grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListPickListSoo &&
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
