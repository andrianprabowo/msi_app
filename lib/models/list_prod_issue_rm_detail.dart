
import 'dart:convert';

import 'package:flutter/material.dart'; 

class ListProdIssueRmDetail with ChangeNotifier {
  final String doNo;
  final String issueRmNo;
  final String issueRmNo1;
  final String doNo1;
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
  int idIssueRmHeader;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  final DateTime deliveryDate;
  final DateTime lastmodified;
  ListProdIssueRmDetail({
    this.doNo,
    this.issueRmNo,
    this.issueRmNo1,
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
    this.docNum,
    this.remark,
    this.grpodlvNo1,
    this.logMessage,
    this.idIssueRmHeader,
    this.status,
    this.idUserInput,
    this.idUserApproved,
    this.back,
    this.postingDate,
    this.deliveryDate,
    this.lastmodified,
  });


 

  Map<String, dynamic> toMap() {
    return {
      'doNo': doNo,
      'issueRmNo': issueRmNo,
      'issueRmNo1': issueRmNo1,
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
      'docNum': docNum,
      'remark': remark,
      'grpodlvNo1': grpodlvNo1,
      'logMessage': logMessage,
      'idIssueRmHeader': idIssueRmHeader,
      // 'idGrpoDlvPlant': idGrpoDlvPlant,
      'status': status,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'lastmodified': lastmodified.toIso8601String(),
    };
  }

  factory ListProdIssueRmDetail.fromMap(Map<String, dynamic> map) {
    return ListProdIssueRmDetail(
      doNo: map['doNo']??'',
      issueRmNo: map['issueRmNo']??'',
      issueRmNo1: map['issueRmNo1']??'',
      doNo1: map['doNo1']??'',
      grpodlvNo: map['grpodlvNo']??'',
      kdVendor: map['kdVendor']??'',
      nmVendor: map['nmVendor']??'',
      plant: map['plant']??'',
      plantName: map['plantName']??'',
      toPlant: map['toPlant']??'',
      storageLocation: map['storageLocation']??'',
      storageLocationName: map['storageLocationName']??'',
      itemGroupCode: map['itemGroupCode']??'',
      fileName: map['fileName']??'',
      docNum: map['docNum']??'',
      remark: map['remark']??'',
      grpodlvNo1: map['grpodlvNo1']??'',
      logMessage: map['logMessage']??'',
      idIssueRmHeader: map['idIssueRmHeader'] ?? 0,
      // idGrpoDlvPlant: map['idGrpoDlvPlant'],
      status: map['s'] ?? 2,
      idUserInput: map['idUserInput'] ?? 0,
      idUserApproved: map['idUserApproved'] ?? 0,
      back: map['back'] ?? 0,
      postingDate: DateTime.parse(map['postingDate']),
      deliveryDate: DateTime.parse(map['deliveryDate']),
      lastmodified: DateTime.parse(map['lastmodified']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListProdIssueRmDetail.fromJson(String source) => ListProdIssueRmDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListProdIssueRmDetail(doNo: $doNo, issueRmNo: $issueRmNo, issueRmNo1: $issueRmNo1, doNo1: $doNo1, grpodlvNo: $grpodlvNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant, plantName: $plantName, toPlant: $toPlant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, grpodlvNo1: $grpodlvNo1, logMessage: $logMessage, idIssueRmHeader: $idIssueRmHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
    // return 'ListProdIssueRmDetail(doNo: $doNo, issueRmNo: $issueRmNo, issueRmNo1: $issueRmNo1, doNo1: $doNo1, grpodlvNo: $grpodlvNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant, plantName: $plantName, toPlant: $toPlant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docNum: $docNum, remark: $remark, grpodlvNo1: $grpodlvNo1, logMessage: $logMessage, idIssueRmHeader: $idIssueRmHeader, idGrpoDlvPlant: $idGrpoDlvPlant, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
  }

  

}
