import 'dart:convert';

import 'package:flutter/material.dart';

class ListGoodReceiptPoOutletDetail with ChangeNotifier {
  final String poNo;
   String rtoNo;
  final String kdVendor;
  final String nmVendor;
  final String plant;
  final String storageLocation;
  final String storageLocationName;
  final String itemGroupCode;
  final String fileName;
  final String docnum;
  final String remark;
  final String rtoNo1;
  final String logMessage;
  int idRtoHeader;
  int status;
  int idUserInput;
  int idUserApproved;
  int back;
  final DateTime postingDate;
  final DateTime deliveryDate;
  final DateTime lastmodified;
  ListGoodReceiptPoOutletDetail({
    this.poNo,
    this.rtoNo,
    this.kdVendor,
    this.nmVendor,
    this.plant,
    this.storageLocation,
    this.storageLocationName,
    this.itemGroupCode,
    this.fileName,
    this.logMessage,
    this.docnum,
    this.remark,
    this.rtoNo1,
    this.idUserInput,
    this.idUserApproved,
    this.back,
    this.idRtoHeader,
    this.status,
    this.postingDate,
    this.deliveryDate,
    this.lastmodified,
  });

  Map<String, dynamic> toMap() {
    return {
      'poNo': poNo,
      'rtoNo': rtoNo,
      'kdVendor': kdVendor,
      'nmVendor': nmVendor,
      'plant': plant,
      'storageLocation': storageLocation,
      'storageLocationName': storageLocationName,
      'itemGroupCode': itemGroupCode,
      'fileName': fileName,
      'logMessage': logMessage,
      'docnum': docnum,
      'remark': remark,
      'rtoNo1': rtoNo1,
      'idRtoHeader': idRtoHeader,
      'status': status,
      'idUserInput': idUserInput,
      'idUserApproved': idUserApproved,
      'back': back,
      'postingDate': postingDate?.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'lastmodified': lastmodified?.toIso8601String(),
    };
  }

  factory ListGoodReceiptPoOutletDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListGoodReceiptPoOutletDetail(
      poNo: map['poNo'] ?? '',
      rtoNo: map['rtoNo'] ?? '',
      kdVendor: map['kdVendor'] ?? '',
      nmVendor: map['nmVendor'] ?? '',
      plant: map['plant'] ?? '',
      storageLocation: map['storageLocation'] ?? '',
      storageLocationName: map['storageLocationName'] ?? '',
      itemGroupCode: map['itemGroupCode'] ?? '',
      fileName: map['filename'] ?? '',
      docnum: map['docnum'] ?? '',
      rtoNo1: map['rtoNo1'] ?? '',
      remark: map['remark'] ?? '',
      idRtoHeader: map['idRtoHeader'] ?? 0,
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

  factory ListGoodReceiptPoOutletDetail.fromJson(String source) =>
      ListGoodReceiptPoOutletDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ListGoodReceiptPoOutletDetail(poNo: $poNo, rtoNo: $rtoNo, kdVendor: $kdVendor, nmVendor: $nmVendor, plant: $plant, storageLocation: $storageLocation, storageLocationName: $storageLocationName, itemGroupCode: $itemGroupCode, fileName: $fileName, docnum: $docnum, remark: $remark, rtoNo1: $rtoNo1, idRtoHeader: $idRtoHeader, status: $status, idUserInput: $idUserInput, idUserApproved: $idUserApproved, back: $back, postingDate: $postingDate, deliveryDate: $deliveryDate, lastmodified: $lastmodified)';
  }
}
