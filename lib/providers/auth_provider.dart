import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:msi_app/models/bin.rfv.dart';
import 'package:msi_app/models/enter_gl.dart';
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/screens/dashboard/dashboard_screen.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/utils/prefs.dart';
import 'package:crypto/crypto.dart';

// final _usage = 'Usage: dart hash.dart <md5|sha1|sha256> <input_filename>';

class AuthProvider with ChangeNotifier {
  String _token;
  String _username;
  String _warehouseId;
  String _warehouseName;
  String _binId;
  String _binGl;

  String get token => _token;
  String get username => _username;
  String get warehouseId => _warehouseId;
  String get warehouseName => _warehouseName;
  String get binId => _binId;
  String get binGl => _binGl;

  Future<void> getData() async {
    _token = await Prefs.getString(Prefs.token);
    _username = await Prefs.getString(Prefs.username);
    _warehouseId = await Prefs.getString(Prefs.warehouseId);
    _warehouseName = await Prefs.getString(Prefs.warehouseName);
    _binId = await Prefs.getString(Prefs.binId);
    _binGl = await Prefs.getString(Prefs.binGl);
    notifyListeners();
  }

  Future<bool> login({
    String username,
    String password,
  }) async {
    var pass = md5.convert(utf8.encode(password)).toString();
    print('password: $password');
    print('md5: $pass');
    final url = '$kBaseUrl/tgrpo/tgrpo/api/pass/username=$username&pass=$pass';
    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      if (data == null) return false;
      print(data);
      if (data.length == 0) return false;

      Map obj = data[0];
      await Prefs.setString(Prefs.username, obj['username']);
      await Prefs.setString(Prefs.token, obj['adminPassword']);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
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

  void clearGl() async {
    // final prefs =  Prefs.binId;
    await Prefs.setString(Prefs.binGl, 'Please input GI Sequence no');
    // prefs.replaceAll(Prefs.binId, 'select bin');
  }

  void selectWarehouse(BuildContext context, Warehouse warehouse) async {
    await Prefs.setString(Prefs.warehouseId, warehouse.whsCode);
    await Prefs.setString(Prefs.warehouseName, warehouse.whsName);

    _warehouseId = warehouse.whsCode;
    _warehouseName = warehouse.whsName;

    notifyListeners();
    Navigator.of(context).pushNamed(DashboardScreen.routeName);
  }

  void selectBin(BinRtv binRtv) async {
    await Prefs.setString(Prefs.binId, binRtv.binCode);
    _binId = binRtv.binCode;

    notifyListeners();
  }


  void selectItemGl(EnterGl enterGl) async {
    await Prefs.setString(Prefs.binGl, enterGl.enterGl);
    _binGl = enterGl.enterGl;

    notifyListeners();
  }
}
