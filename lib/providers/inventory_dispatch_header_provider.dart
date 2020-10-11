import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header.dart';

class InventoryDispatchHeaderProvider with ChangeNotifier {
  String _zonation;
  InventoryDispatchHeader _header;

  String get zonation => _zonation;
  InventoryDispatchHeader get header => _header;

  void setZonation(String zonation) {
    _zonation = zonation;
  }

  void setHeader(InventoryDispatchHeader inventoryDispatchHeader) {
    print(inventoryDispatchHeader);
    _header = inventoryDispatchHeader;
  }
}
