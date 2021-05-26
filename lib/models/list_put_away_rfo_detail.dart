import 'dart:convert';

import 'package:flutter/material.dart';



class ListPutAwayRfoDetail with ChangeNotifier {
  final String pwyrtono;
  final String pwyrtono1;
  String grpodlvNo;
  final String kdVendor;
  final String nmVendor;
  final String plant;
  final String plantName;
  final String storageLocation;
  final String storageLocationName;
  final String itemGroupCode;
  final String fileName;
  final String docNum;
  final String remark;
  final String grpodlvNo1;
  final String logMessage;
  int idPwyrtoHeader;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  // final DateTime deliveryDate;
  final DateTime lastmodified;
  ListPutAwayRfoDetail({
    this.pwyrtono,
    this.pwyrtono1,
    this.grpodlvNo,
    this.kdVendor,
    this.nmVendor,
    this.plant,
    this.plantName,
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
    this.idPwyrtoHeader,
    this.status,
    this.postingDate,
    // this.deliveryDate,
    this.lastmodified,
  });

  Map<String, dynamic> toMap() {
    return {
      'pwyrtono': pwyrtono,
      'pwyrtono1': pwyrtono1,
      'grpodlvNo': grpodlvNo,
      'kdVendor': kdVendor,
      'nmVendor': nmVendor,
      'plant': plant,
      'plantName': plantName,
      'storageLocation': storageLocation,
      'storageLocationName': storageLocationName,
      'itemGroupCode': itemGroupCode,
      'fileName': fileName,
      'logMessage': logMessage,
      'docNum': docNum,
      'remark': remark,
      'grpodlvNo1': grpodlvNo1,
      'idPwyrtoHeader': idPwyrtoHeader,
      'status': status,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate?.toIso8601String(),
      // 'deliveryDate': deliveryDate?.toIso8601String(),
      'lastmodified': lastmodified?.toIso8601String(),
    };
  }

  factory ListPutAwayRfoDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListPutAwayRfoDetail(
      pwyrtono: map['pwyrtono'] ?? '',
      pwyrtono1: map['pwyrtono1'] ?? '',
      grpodlvNo: map['grpodlvNo'] ?? '',
      kdVendor: map['kdVendor'] ?? '',
      nmVendor: map['nmVendor'] ?? '',
      plant: map['plant'] ?? '',
      plantName: map['plantName'] ?? '',
      storageLocation: map['storageLocation'] ?? '',
      storageLocationName: map['storageLocationName'] ?? '',
      itemGroupCode: map['itemGroupCode'] ?? '',
      fileName: map['filename'] ?? '',
      docNum: map['docNum'] ?? '',
      grpodlvNo1: map['grpodlvNo1'] ?? '',
      remark: map['remark'] ?? '',
      idPwyrtoHeader: map['idPwyrtoHeader'] ?? 0,
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

  factory ListPutAwayRfoDetail.fromJson(String source) =>
      ListPutAwayRfoDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListPutAwayRfoDetail(dgrpodlvNo: $grpodlvNo)';
    // return 'ListPutAwayRfoDetail(pwyrtono: $pwyrtono,pwyrtono1: $pwyrtono1, grpodlvNo: $grpodlvNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant,plantName: $plantName, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, grpodlvNo1: $grpodlvNo1, idPwyrtoHeader: $idPwyrtoHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
  }
}
