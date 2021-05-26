import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionReceiptAllTransactionModel with ChangeNotifier {
  final String issueNo;
  final String wono;
  final String logMessage;
  final int status;
  final int idGrpofgHeader;
  final DateTime docDate;
  ProductionReceiptAllTransactionModel({
    this.issueNo, 
    this.wono, 
    this.idGrpofgHeader, 
    this.status, 
    this.logMessage, 
    this.docDate,
  });

  ProductionReceiptAllTransactionModel copyWith({
    String issueNo,
    String wono,
    String logMessage,
    int status,
    DateTime docDate,
  }) {
    return ProductionReceiptAllTransactionModel(
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
      'logMessage': logMessage,
      'idGrpofgHeader': idGrpofgHeader,
    };
  }

  factory ProductionReceiptAllTransactionModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionReceiptAllTransactionModel(
      issueNo: map['issueNo'] ?? '',
      wono: map['wono'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      status: map['status'] ?? 3,
      idGrpofgHeader: map['idGrpofgHeader'] ?? 0,
      logMessage: map['logMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionReceiptAllTransactionModel.fromJson(String source) =>
      ProductionReceiptAllTransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionReceiptAllTransactionModel(issueNo: $issueNo, wono: $wono, docDate: $docDate, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductionReceiptAllTransactionModel &&
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
