import 'dart:convert';

import 'package:flutter/material.dart';

class ListGoodReceiptPoDetail with ChangeNotifier {
  final String poNo;
   String grpoNo;
  final String kdVendor;
  final String nmVendor;
  final String plant;
  final String storageLocation;
  final String storageLocationName;
  final String itemGroupCode;
  final String fileName;
  final String docNum;
  final String remark;
  final String grpoNo1;
  final String logMessage;
  int idGrpoHeader;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  final DateTime deliveryDate;
  final DateTime lastmodified;
  ListGoodReceiptPoDetail({
    this.poNo,
    this.grpoNo,
    this.kdVendor,
    this.nmVendor,
    this.plant,
    this.storageLocation,
    this.storageLocationName,
    this.itemGroupCode,
    this.fileName,
    this.logMessage,
    this.docNum,
    this.remark,
    this.grpoNo1,
    this.idUserInput,
    this.idUserApproved,
    this.back,
    this.idGrpoHeader,
    this.status,
    this.postingDate,
    this.deliveryDate,
    this.lastmodified,
  });

  Map<String, dynamic> toMap() {
    return {
      'poNo': poNo,
      'grpoNo': grpoNo,
      'kdVendor': kdVendor,
      'nmVendor': nmVendor,
      'plant': plant,
      'storageLocation': storageLocation,
      'storageLocationName': storageLocationName,
      'itemGroupCode': itemGroupCode,
      'fileName': fileName,
      'logMessage': logMessage,
      'docNum': docNum,
      'remark': remark,
      'grpoNo1': grpoNo1,
      'idGrpoHeader': idGrpoHeader,
      'status': status,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate?.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'lastmodified': lastmodified?.toIso8601String(),
    };
  }

  factory ListGoodReceiptPoDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListGoodReceiptPoDetail(
      poNo: map['poNo'] ?? '',
      grpoNo: map['grpoNo'] ?? '',
      kdVendor: map['kdVendor'] ?? '',
      nmVendor: map['nmVendor'] ?? '',
      plant: map['plant'] ?? '',
      storageLocation: map['storageLocation'] ?? '',
      storageLocationName: map['storageLocationName'] ?? '',
      itemGroupCode: map['itemGroupCode'] ?? '',
      fileName: map['filename'] ?? '',
      docNum: map['docNum'] ?? '',
      grpoNo1: map['grpoNo1'] ?? '',
      remark: map['remark'] ?? '',
      idGrpoHeader: map['idGrpoHeader'] ?? 0,
      status: map['s'] ?? 2,  // set status sama dengan 2
      logMessage: map['logMessage'] ?? '',
      back: map['back'] ?? 0,
      idUserApproved: map['idUserApproved'] ?? 0,
      idUserInput: map['idUserInput'] ?? 0,
      postingDate: DateTime.parse(map['postingDate']),
      deliveryDate: DateTime.parse(map['deliveryDate']),
      lastmodified: DateTime.parse(map['lastmodified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListGoodReceiptPoDetail.fromJson(String source) =>
      ListGoodReceiptPoDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListGoodReceiptPoDetail(poNo: $poNo, grpoNo: $grpoNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, grpoNo1: $grpoNo1, idGrpoHeader: $idGrpoHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
  }
}
