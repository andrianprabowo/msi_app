import 'package:flutter/material.dart';
import 'package:msi_app/models/temp_batch_putaway.dart';

class TempBatchPutawayProvider with ChangeNotifier {
  List<TempBatchPutaway> _itemsBin = [];
  TempBatchPutaway _selected;

  List<TempBatchPutaway> get itemsBins => _itemsBin;
  TempBatchPutaway get selected => _selected;

  // int _show = 1;

  List<TempBatchPutaway> get items {
    // // var show = 1;

    // _itemsBin.forEach((item) {
    //   if (item.tempQty == 0) {
    //     // show = show + 1;
    //   }
    // });
    // // _show = show;
    // _itemsBin.forEach((detail) {});

    // return _itemsBin;
  }

  List<TempBatchPutaway> get pickedItems {
    return _itemsBin.where((item) => item.tempQty > 0).toList();
  }

  // double get totalPicked => _totalPicked;

  TempBatchPutaway findByBatchNo(String batchNo) {
    return _itemsBin.firstWhere((item) => item.tempBatch == batchNo);
  }

  bool contains(TempBatchPutaway item) {
    for (TempBatchPutaway e in items) {
      if (e == item) return true;
    }
    return false;
  }

//  void addBin(
//     ItemBin item,
//     TempBatchPutaway batchList,
//   ) {
//     item.
//     item.add(batchList);
//     notifyListeners();
//     print('N Added Bin List: $batchList');
//   }

//   void addTempBatch(
//     ItemBin itemBin,
//     List<TempBatchPutaway> batchList,
//   ) {
//     itemBin.batchList.addAll(batchList);
//     notifyListeners();
//     print('Added Batch List: $batchList');
//   }

void inputTempBatch(TempBatchPutaway tempBatch, double qty) {
    print('Update temmmmppp Nosdsadssn batch: ');

    tempBatch.tempQty = qty;
    notifyListeners();
    print('Update temmmmppp Non batch: $tempBatch');
  }

  void inputTempValue(TempBatchPutaway item, double qty, String batchNumber,
      BuildContext context) {
    // update qty
    item.tempQty = qty;
    item.tempBatch = batchNumber;

    final contain = contains(item);
    print(contain);
    if (contain) {
      final searchItem =
          items.where((element) => element.tempBatch == item.tempBatch).first;
      searchItem.tempQty = qty;
    } else {
      items.add(item);
    }
    notifyListeners();
    print('inputQty : $qty');
    print("test temp batch ${item.tempBatch}");
    print("test temp qty ${item.tempQty}");
  }

  void clear() {
    _itemsBin.forEach((item) => item.tempQty = 0.0);

    notifyListeners();
  }

void selectPo(TempBatchPutaway purchaseOrder) {
    _selected = purchaseOrder;
    notifyListeners();
  }

  TempBatchPutaway findBinByBatchCode(String batch) {
    return _itemsBin.firstWhere((element) => element.tempBatch == batch);
  }

}
