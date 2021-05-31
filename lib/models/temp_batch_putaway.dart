import 'dart:convert';

import 'package:flutter/material.dart';

class TempBatchPutaway with ChangeNotifier {
   String tempBatch;
   double tempQty;
  TempBatchPutaway({
    this.tempBatch,
    this.tempQty,
  });

  TempBatchPutaway copyWith({
    String tempBatch,
    double tempQty,
    DateTime expiredDate,
  }) {
    return TempBatchPutaway(
      tempBatch: tempBatch ?? this.tempBatch,
      tempQty: tempQty ?? this.tempQty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tempBatch': tempBatch,
      'batchQuantity': tempQty.toString(),
    };
  }

  factory TempBatchPutaway.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TempBatchPutaway(
      tempBatch: map['tempBatch'] ?? '',
      tempQty: map['avlQty'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TempBatchPutaway.fromJson(String source) =>
      TempBatchPutaway.fromMap(json.decode(source));

  @override
  String toString() =>
      'TempBatchPutaway(tempBatch: $tempBatch, tempQty: $tempQty)';

  
}
