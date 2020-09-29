import 'package:flutter/cupertino.dart';
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  String _username;
  String _warehouseId;
  String _warehouseName;

  String get token => _token;
  String get username => _username;
  String get warehouseId => _warehouseId;
  String get warehouseName => _warehouseName;

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _username = prefs.getString('username');
    _warehouseId = prefs.getString('warehouseId');
    _warehouseName = prefs.getString('warehouseName');
  }

  Future<void> login({
    String username,
    Warehouse warehouse,
    BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('token', 'TOKEN');
    prefs.setString('warehouseId', warehouse.whsCode);
    prefs.setString('warehouseName', warehouse.whsName);

    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
