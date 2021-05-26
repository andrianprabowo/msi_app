import 'dart:convert';

import 'package:flutter/material.dart';

class ProductionPickListAllTransactionModel with ChangeNotifier {
  final String pickListNo;
  final String srno;
  final String logMessage;
  final int status;
  final int picklistSapnumber;
  final int idPlrmHeader;
  final DateTime docDate;
  ProductionPickListAllTransactionModel({
    this.pickListNo,
    this.srno,
    this.status,
    this.picklistSapnumber,
    this.idPlrmHeader,
    this.logMessage,
    this.docDate,
  });

  ProductionPickListAllTransactionModel copyWith({
    String pickListNo,
    String srno,
    String logMessage,
    int status,
    DateTime docDate,
  }) {
    return ProductionPickListAllTransactionModel(
      pickListNo: pickListNo ?? this.pickListNo,
      srno: srno ?? this.srno,
      docDate: docDate ?? this.docDate,
      status: status ?? this.status,
      logMessage: logMessage ?? this.logMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickListNo': pickListNo,
      'srno': srno,
      'docDate': docDate?.toIso8601String(),
      'status': status,
      'logMessage': logMessage,
      'idPlrmHeader': idPlrmHeader,
    };
  }

  factory ProductionPickListAllTransactionModel.fromMap(
      Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionPickListAllTransactionModel(
      pickListNo: map['pickListNo'] ?? '',
      srno: map['srno'] ?? '',
      docDate: DateTime.parse(map['docDate']),
      status: map['status'] ?? '3',
      picklistSapnumber: map['picklistSapnumber'] ?? 0,
      logMessage: map['logMessage'] ?? '',
      idPlrmHeader: map['idPlrmHeader'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductionPickListAllTransactionModel.fromJson(String source) =>
      ProductionPickListAllTransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductionPickListAllTransactionModel(pickListNo: $pickListNo, srno: $srno, docDate: $docDate, status: $status, logMessage: $logMessage)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductionPickListAllTransactionModel &&
        o.pickListNo == pickListNo &&
        o.srno == srno &&
        o.docDate == docDate &&
        o.status == status &&
        o.logMessage == logMessage;
  }

  @override
  int get hashCode {
    return pickListNo.hashCode ^
        srno.hashCode ^
        docDate.hashCode ^
        status.hashCode ^
        logMessage.hashCode;
  }
}
