import 'package:flutter/material.dart';
import 'package:msi_app/models/bin.rfv.dart';
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/utils/prefs.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  String _username;
  String _warehouseId;
  String _warehouseName;
  String _binId;

  String get token => _token;
  String get username => _username;
  String get warehouseId => _warehouseId;
  String get warehouseName => _warehouseName;
  String get binId => _binId;

  Future<void> getData() async {
    _token = await Prefs.getString(Prefs.token);
    _username = await Prefs.getString(Prefs.username);
    _warehouseId = await Prefs.getString(Prefs.warehouseId);
    _warehouseName = await Prefs.getString(Prefs.warehouseName);
    _binId = await Prefs.getString(Prefs.binId);
    notifyListeners();
  }

  Future<void> login({
    BuildContext context,
    String username,
  }) async {
    await Prefs.setString(Prefs.username, username);
    await Prefs.setString(Prefs.token, 'TOKEN');

    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await Prefs.prefs;
    prefs.clear();

    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  void clearBin() async {
    // final prefs =  Prefs.binId;
    await Prefs.setString(Prefs.binId, 'Please Select Bin');
    // prefs.replaceAll(Prefs.binId, 'select bin');

  }

  void selectWarehouse(Warehouse warehouse) async {
    await Prefs.setString(Prefs.warehouseId, warehouse.whsCode);
    await Prefs.setString(Prefs.warehouseName, warehouse.whsName);

    _warehouseId = warehouse.whsCode;
    _warehouseName = warehouse.whsName;

    notifyListeners();
  }

  void selectBin(BinRtv binRtv) async {
    await Prefs.setString(Prefs.binId, binRtv.binCode);
    _binId = binRtv.binCode;

    notifyListeners();
  }
}
