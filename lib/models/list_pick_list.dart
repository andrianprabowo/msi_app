import 'dart:convert';

import 'package:flutter/material.dart';

class ListPickList with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final int picklistSapnumber;
  final String logMessage;
  ListPickList({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.picklistSapnumber,
    this.logMessage,
  });

  ListPickList copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListPickList(
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
      'srno': poNo,
      'docDate': docDate?.toIso8601String(),
      'vendor': vendor,
      'status': status,
      'logMessage': logMessage,
    };
  }

  factory ListPickList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPickList(
      grpono: map['pickListNo'] ?? '',
      poNo: map['srno'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      picklistSapnumber: map['picklistSapnumber'] ?? 0,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPickList.fromJson(String source) =>
      ListPickList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPickList(picklistSapnumber: $picklistSapnumber,grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListPickList &&
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
