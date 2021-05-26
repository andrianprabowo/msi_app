import 'dart:convert';

import 'package:flutter/material.dart';


class ListInvDispatchSoDetail with ChangeNotifier {
  final String doNo;
  final String doNo1;
   String soidpNo;
  final String kdVendor;
  final String nmVendor;
  final String plant;
  final String plantName;
  final String toPlant;
  // final String idSoidpPlant;
  final String storageLocation;
  final String storageLocationName;
  final String itemGroupCode;
  final String fileName;
  final String docNum;
  final String remark;
  final String soidpNo1;
  final String logMessage;
  int idSoidpHeader;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  final DateTime deliveryDate;
  final DateTime lastmodified;
  ListInvDispatchSoDetail({
    this.doNo,
    this.doNo1,
    this.soidpNo,
    this.kdVendor,
    this.nmVendor,
    this.plant,
    this.toPlant,
    // this.idSoidpPlant,
    this.plantName,
    this.storageLocation,
    this.storageLocationName,
    this.itemGroupCode,
    this.fileName,
    this.logMessage,
    this.docNum,
    this.remark,
    this.soidpNo1,
    this.idUserInput,
    this.idUserApproved,
    this.back,
    this.idSoidpHeader,
    this.status,
    this.postingDate,
    this.deliveryDate,
    this.lastmodified,
  });

  Map<String, dynamic> toMap() {
    return {
      'doNo': doNo,
      'doNo1': doNo1,
      'soidpNo': soidpNo,
      'kdVendor': kdVendor,
      'nmVendor': nmVendor,
      'plant': plant,
      'plantName': plantName,
      'toPlant': toPlant,
      // 'idSoidpPlant': idSoidpPlant,
      'storageLocation': storageLocation,
      'storageLocationName': storageLocationName,
      'itemGroupCode': itemGroupCode,
      'fileName': fileName,
      'logMessage': logMessage,
      'docNum': docNum,
      'remark': remark,
      'soidpNo1': soidpNo1,
      'idSoidpHeader': idSoidpHeader,
      'status': status,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate?.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'lastmodified': lastmodified?.toIso8601String(),
    };
  }

  factory ListInvDispatchSoDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListInvDispatchSoDetail(
      doNo: map['doNo'] ?? '',
      doNo1: map['doNo1'] ?? '',
      soidpNo: map['soidpNo'] ?? '',
      kdVendor: map['kdVendor'] ?? '',
      nmVendor: map['nmVendor'] ?? '',
      plant: map['plant'] ?? '',
      toPlant: map['toPlant'] ?? '',
      plantName: map['plantName'] ?? '',
      // idSoidpPlant: map['idSoidpPlant'] ?? '',
      storageLocation: map['storageLocation'] ?? '',
      storageLocationName: map['storageLocationName'] ?? '',
      itemGroupCode: map['itemGroupCode'] ?? '',
      fileName: map['filename'] ?? '',
      docNum: map['docNum'] ?? '',
      soidpNo1: map['soidpNo1'] ?? '',
      remark: map['remark'] ?? '',
      idSoidpHeader: map['idSoidpHeader'] ?? 0,
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

  factory ListInvDispatchSoDetail.fromJson(String source) =>
      ListInvDispatchSoDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListInvDispatchSoDetail(doNo: $doNo, soidpNo: $soidpNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, soidpNo1: $soidpNo1, idSoidpHeader: $idSoidpHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
  }
}
