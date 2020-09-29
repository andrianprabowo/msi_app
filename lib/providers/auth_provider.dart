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

  Future<void> login({
    String username,
    Warehouse warehouse,
    BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('token', 'TOKEN');
    prefs.setString('whsCode', warehouse.whsCode);
    prefs.setString('whsName', warehouse.whsName);

    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
