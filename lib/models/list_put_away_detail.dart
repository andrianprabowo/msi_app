import 'dart:convert';

import 'package:flutter/material.dart';

class ListPutAwayDetail with ChangeNotifier {
  final String doNo;
  final String doNo1;
  String grpodlvNo;
  final String kdVendor;
  final String nmVendor;
  final String plant;
  final String toPlant;
  final String storageLocation;
  final String storageLocationName;
  final String itemGroupCode;
  final String fileName;
  final String docNum;
  final String remark;
  final String grpodlvNo1;
  final String logMessage;
  int idGrpodlvHeader;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  // final DateTime deliveryDate;
  final DateTime lastmodified;
  ListPutAwayDetail({
    this.doNo,
    this.doNo1,
    this.grpodlvNo,
    this.kdVendor,
    this.nmVendor,
    this.plant,
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
    this.idGrpodlvHeader,
    this.status,
    this.postingDate,
    // this.deliveryDate,
    this.lastmodified,
  });

  Map<String, dynamic> toMap() {
    return {
      'doNo': doNo,
      'doNo1': doNo1,
      'grpodlvNo': grpodlvNo,
      'kdVendor': kdVendor,
      'nmVendor': nmVendor,
      'plant': plant,
      'toPlant': toPlant,
      'storageLocation': storageLocation,
      'storageLocationName': storageLocationName,
      'itemGroupCode': itemGroupCode,
      'fileName': fileName,
      'logMessage': logMessage,
      'docNum': docNum,
      'remark': remark,
      'grpodlvNo1': grpodlvNo1,
      'idGrpodlvHeader': idGrpodlvHeader,
      'status': status,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate?.toIso8601String(),
      // 'deliveryDate': deliveryDate?.toIso8601String(),
      'lastmodified': lastmodified?.toIso8601String(),
    };
  }

  factory ListPutAwayDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPutAwayDetail(
      doNo: map['doNo'] ?? '',
      doNo1: map['doNo1'] ?? '',
      grpodlvNo: map['grpodlvNo'] ?? '',
      kdVendor: map['kdVendor'] ?? '',
      nmVendor: map['nmVendor'] ?? '',
      plant: map['plant'] ?? '',
      toPlant: map['toPlant'] ?? '',
      storageLocation: map['storageLocation'] ?? '',
      storageLocationName: map['storageLocationName'] ?? '',
      itemGroupCode: map['itemGroupCode'] ?? '',
      fileName: map['filename'] ?? '',
      docNum: map['docNum'] ?? '',
      grpodlvNo1: map['grpodlvNo1'] ?? '',
      remark: map['remark'] ?? '',
      idGrpodlvHeader: map['idGrpodlvHeader'] ?? 0,
      status: map['s'] ?? 2, // set status sama dengan 2
      logMessage: map['logMessage'] ?? '',
      back: map['back'] ?? 0,
      idUserApproved: map['idUserApproved'] ?? 0,
      idUserInput: map['idUserInput'] ?? 0,
      postingDate: DateTime.parse(map['postingDate'])??'',
      // deliveryDate: DateTime.parse(map['deliveryDate']??''),
      lastmodified: DateTime.parse(map['lastmodified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPutAwayDetail.fromJson(String source) =>
      ListPutAwayDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPutAwayDetail(dgrpodlvNo: $grpodlvNo)';
    // return 'ListPutAwayDetail(doNo: $doNo,doNo1: $doNo1, grpodlvNo: $grpodlvNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant,toPlant: $toPlant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, grpodlvNo1: $grpodlvNo1, idGrpodlvHeader: $idGrpodlvHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
  }
}
