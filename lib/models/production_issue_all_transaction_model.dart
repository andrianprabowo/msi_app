import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionIssueAllTransactionModel with ChangeNotifier {
  final String issueNo;
  final String wono;
  final String logMessage;
  final int status;
  final int idIssueRmHeader;
  final DateTime docDate;
  ProductionIssueAllTransactionModel({
    this.issueNo, 
    this.wono, 
    this.status, 
    this.idIssueRmHeader, 
    this.logMessage, 
    this.docDate,
  });

  ProductionIssueAllTransactionModel copyWith({
    String issueNo,
    String wono,
    String logMessage,
    int status,
    DateTime docDate,
  }) {
    return ProductionIssueAllTransactionModel(
      issueNo: issueNo ?? this.issueNo,
      wono: wono ?? this.wono,
      docDate: docDate ?? this.docDate,
      status: status ?? this.status,
      logMessage: logMessage ?? this.logMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'issueNo': issueNo,
      'wono': wono,
      'docDate': docDate?.toIso8601String(),
      'status': status,
      'idIssueRmHeader': idIssueRmHeader,
      'logMessage': logMessage,
    };
  }

  factory ProductionIssueAllTransactionModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionIssueAllTransactionModel(
      issueNo: map['issueNo'] ?? '',
      wono: map['wono'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      status: map['status'] ?? '3',
      idIssueRmHeader: map['idIssueRmHeader'] ?? 0,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionIssueAllTransactionModel.fromJson(String source) =>
      ProductionIssueAllTransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionIssueAllTransactionModel(issueNo: $issueNo, wono: $wono, docDate: $docDate, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductionIssueAllTransactionModel &&
        o.issueNo == issueNo &&
        o.wono == wono &&
        o.docDate == docDate &&
        o.status == status &&
        o.logMessage == logMessage;
  }

  @override
  int get hashCode {
    return issueNo.hashCode ^
        wono.hashCode ^
        docDate.hashCode ^
        status.hashCode ^
        logMessage.hashCode;
  }
}
