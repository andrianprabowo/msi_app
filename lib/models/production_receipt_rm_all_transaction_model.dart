import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionReceiptRMAllTransactionModel with ChangeNotifier {
  final String putAwayNo;
  final String srno;
  final String logMessage;
  final int status;
  final DateTime docDate;
  ProductionReceiptRMAllTransactionModel({
    this.putAwayNo, 
    this.srno, 
    this.status, 
    this.logMessage, 
    this.docDate,
  });

  ProductionReceiptRMAllTransactionModel copyWith({
    String putAwayNo,
    String srno,
    String logMessage,
    int status,
    DateTime docDate,
  }) {
    return ProductionReceiptRMAllTransactionModel(
      putAwayNo: putAwayNo ?? this.putAwayNo,
      srno: srno ?? this.srno,
      docDate: docDate ?? this.docDate,
      status: status ?? this.status,
      logMessage: logMessage ?? this.logMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'putAwayNo': putAwayNo,
      'srno': srno,
      'docDate': docDate?.toIso8601String(),
      'status': status,
      'logMessage': logMessage,
    };
  }

  factory ProductionReceiptRMAllTransactionModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionReceiptRMAllTransactionModel(
      putAwayNo: map['putAwayNo'] ?? '',
      srno: map['srno'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      status: map['status'] ?? '3',
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptRMAllTransactionModel.fromJson(String source) =>
      ProductionReceiptRMAllTransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionReceiptRMAllTransactionModel(putAwayNo: $putAwayNo, srno: $srno, docDate: $docDate, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductionReceiptRMAllTransactionModel &&
        o.putAwayNo == putAwayNo &&
        o.srno == srno &&
        o.docDate == docDate &&
        o.status == status &&
        o.logMessage == logMessage;
  }

  @override
  int get hashCode {
    return putAwayNo.hashCode ^
        srno.hashCode ^
        docDate.hashCode ^
        status.hashCode ^
        logMessage.hashCode;
  }
}
