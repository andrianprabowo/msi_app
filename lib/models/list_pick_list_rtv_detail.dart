import 'dart:convert';

import 'package:flutter/material.dart';

class ListPickListRtvDetail with ChangeNotifier {
  final String doNo;
  final String doNo1;
  final String rvplNo;
  final String rvplNo1;
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
  int idRvplHeader;
  int idGrpoDlvPlant;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  // final DateTime deliveryDate;
  final DateTime lastmodified;
  ListPickListRtvDetail({
    this.doNo,
    this.rvplNo,
    this.rvplNo1,
    this.doNo1,
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
    this.idGrpoDlvPlant,
    this.idUserInput,
    this.idUserApproved,
    this.back,
    this.idRvplHeader,
    this.status,
    this.postingDate,
    // this.deliveryDate,
    this.lastmodified,
  });

  Map<String, dynamic> toMap() {
    return {
      'doNo': doNo,
      'rvplNo': rvplNo,
      'rvplNo1': rvplNo1,
      'doNo1': doNo1,
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
      'idRvplHeader': idRvplHeader,
      'status': status,
      'idGrpoDlvPlant': idGrpoDlvPlant,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate?.toIso8601String(),
      // 'deliveryDate': deliveryDate?.toIso8601String(),
      'lastmodified': lastmodified?.toIso8601String(),
    };
  }

  factory ListPickListRtvDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPickListRtvDetail(
      doNo: map['doNo'] ?? '',
      rvplNo: map['rvplNo'] ?? '',
      rvplNo1: map['rvplNo1'] ?? '',
      doNo1: map['doNo1'] ?? '',
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
      idRvplHeader: map['idRvplHeader'] ?? 0,
      idGrpoDlvPlant: map['idGrpoDlvPlant'] ?? 0,
      status: map['s'] ?? 2, // set status sama dengan 2
      logMessage: map['logMessage'] ?? '',
      back: map['back'] ?? 0,
      idUserApproved: map['idUserApproved'] ?? 0,
      idUserInput: map['idUserInput'] ?? 0,
      postingDate: DateTime.parse(map['postingDate'])??DateTime.parse(map[DateTime.now()]),
      // deliveryDate: DateTime.parse(map['deliveryDate']??''),
      lastmodified: DateTime.parse(map['lastmodified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPickListRtvDetail.fromJson(String source) =>
      ListPickListRtvDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPickListRtvDetail(dgrpodlvNo: $grpodlvNo)';
    // return 'ListPickListRtvDetail(doNo: $doNo, doNo1: $doNo1, grpodlvNo: $grpodlvNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant,toPlant: $toPlant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, grpodlvNo1: $grpodlvNo1, idRvplHeader: $idRvplHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
  }
}
