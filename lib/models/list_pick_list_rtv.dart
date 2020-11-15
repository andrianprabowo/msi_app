import 'dart:convert';

import 'package:flutter/material.dart';

class ListPickListRtv with ChangeNotifier {
  final String grpono;
  final String poNo;
  final DateTime docDate;
  final String vendor;
  final int status;
  final String logMessage;
  ListPickListRtv({
    this.grpono,
    this.poNo,
    this.docDate,
    this.vendor,
    this.status,
    this.logMessage,
  });

  ListPickListRtv copyWith({
    String grpono,
    String poNo,
    DateTime docDate,
    String vendor,
    int status,
  }) {
    return ListPickListRtv(
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
      'doNo': poNo,
      'docDate': docDate?.toIso8601String(),
      'vendor': vendor,
      'status': status,
      'logMessage': logMessage,
    };
  }

  factory ListPickListRtv.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPickListRtv(
      grpono: map['pickListNo'] ?? '',
      poNo: map['returnNo'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      vendor: map['vendor'] ?? '',
      status: map['status'] ?? 3,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPickListRtv.fromJson(String source) =>
      ListPickListRtv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPickListRtv(grpono: $grpono, poNo: $poNo, docDate: $docDate, vendor: $vendor, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListPickListRtv &&
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
