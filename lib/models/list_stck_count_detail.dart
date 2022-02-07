import 'dart:convert';

import 'package:flutter/material.dart';

class ListStckCountDetail with ChangeNotifier {
  final String stckcntingNo;
  final String stckcntingNo1;
  String grpodlvNo;
  final String kdVendor;
  final String nmVendor;
  final String plant;
  final String plantName;
  final String toPlant;
  final String storageLocation;
  final String storageLocationName;
  final String itemGroupCode;
  final String fileName;
  final String docNum;
  final String remark;
  final String grpodlvNo1;
  final String logMessage;
  int idStckcntingHeader;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  final DateTime createdDate;
  final DateTime lastmodified;
  ListStckCountDetail({
    this.stckcntingNo,
    this.stckcntingNo1,
    this.grpodlvNo,
    this.kdVendor,
    this.nmVendor,
    this.plant,
    this.plantName,
    this.toPlant,
    this.storageLocation,
    this.storageLocationName,
    this.itemGroupCode,
    this.fileName,
    this.logMessage,
    this.docNum,
    this.remark,
    this.grpodlvNo1,
    this.idUserInput,
    this.idUserApproved,
    this.back,
    this.idStckcntingHeader,
    this.status,
    this.postingDate,
    this.createdDate,
    this.lastmodified,
  });

  Map<String, dynamic> toMap() {
    return {
      'stckcntingNo': stckcntingNo,
      'stckcntingNo1': stckcntingNo1,
      'grpodlvNo': grpodlvNo,
      'kdVendor': kdVendor,
      'nmVendor': nmVendor,
      'plant': plant,
      'plantName': plantName,
      'toPlant': toPlant,
      'storageLocation': storageLocation,
      'storageLocationName': storageLocationName,
      'itemGroupCode': itemGroupCode,
      'fileName': fileName,
      'logMessage': logMessage,
      'docNum': docNum,
      'remark': remark,
      'grpodlvNo1': grpodlvNo1,
      'idStckcntingHeader': idStckcntingHeader,
      'status': status,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'createdDate': createdDate?.toIso8601String(),
      'lastmodified': lastmodified?.toIso8601String(),
    };
  }

  factory ListStckCountDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListStckCountDetail(
      stckcntingNo: map['stckcntingNo'] ?? '',
      stckcntingNo1: map['stckcntingNo1'] ?? '',
      grpodlvNo: map['grpodlvNo'] ?? '',
      kdVendor: map['kdVendor'] ?? '',
      nmVendor: map['nmVendor'] ?? '',
      plant: map['plant'] ?? '',
      plantName: map['plantName'] ?? '',
      toPlant: map['toPlant'] ?? '',
      storageLocation: map['storageLocation'] ?? '',
      storageLocationName: map['storageLocationName'] ?? '',
      itemGroupCode: map['itemGroupCode'] ?? '',
      fileName: map['filename'] ?? '',
      docNum: map['docNum'] ?? '',
      grpodlvNo1: map['grpodlvNo1'] ?? '',
      remark: map['remark'] ?? '',
      idStckcntingHeader: map['idStckcntingHeader'] ?? 0,
      status: map['s'] ?? 2, // set status sama dengan 2
      logMessage: map['logMessage'] ?? '',
      back: map['back'] ?? 0,
      idUserApproved: map['idUserApproved'] ?? 0,
      idUserInput: map['idUserInput'] ?? 0,
      postingDate: DateTime.parse(map['postingDate'])??'',
      createdDate: DateTime.parse(map['createdDate']??''),
      lastmodified: DateTime.parse(map['lastmodified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListStckCountDetail.fromJson(String source) =>
      ListStckCountDetail.fromMap(json.decode(source));

  @override
  String toString() {
    // return 'ListStckCountDetail(dgrpodlvNo: $grpodlvNo)';
    return 'ListStckCountDetail(stckcntingNo: $stckcntingNo,stckcntingNo1: $stckcntingNo1, grpodlvNo: $grpodlvNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant,toPlant: $toPlant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, grpodlvNo1: $grpodlvNo1, idStckcntingHeader: $idStckcntingHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, createdDate: $createdDate, lastmodified: $lastmodified)';
  }
}
