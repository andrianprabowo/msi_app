import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:provider/provider.dart';

class StockCountingBinProvider with ChangeNotifier {
  List<StockCountingBin> _items = [];
  var _showAllBin = false;
  StockCountingBin _selected;

  List<StockCountingBin> get items {
    return _showAllBin ? _items : _items.toList();
  }

  StockCountingBin get selected => _selected;

  bool get showAllBin => _showAllBin;

  void toggleStatus() {
    _showAllBin = !_showAllBin;
    notifyListeners();
  }

  void selectStagingBin(StockCountingBin binLocation) {
    _selected = binLocation;
    notifyListeners();
  }

  void updateStatus(String bin) {
    StockCountingBin item =
        _items.where((item) => item.binLocation == bin).first;
    if (item != null) {
      item.status = 1;
    }
    notifyListeners();
  }

  Future<void> getPlBinList(
    BuildContext context,
  ) async {
    final warehouseId = await Prefs.getString(Prefs.warehouseId);
    final header =
        Provider.of<StockCountingHeaderProvider>(context, listen: false)
            .selected;
    final docnum = header.pickNumber;
    final username = await Prefs.getString(Prefs.username);
    final url = '$kBaseUrl/api/getstcbin/whscode=$warehouseId&docnum=$docnum&cardcode=$username';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      print(data);
      if (data == null) return;

      final List<StockCountingBin> list = [];
      data.forEach((map) {
        list.add(StockCountingBin.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  StockCountingBin findByBinLocation(String binLocation) {
    return _items.firstWhere((element) => element.binLocation == binLocation);
  }
}
