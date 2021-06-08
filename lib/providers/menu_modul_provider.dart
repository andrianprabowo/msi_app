import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/menu_modul.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';

class MenuModulProvider with ChangeNotifier {
  List<MenuModul> _items;

  List<MenuModul> get items => _items;

  Future<void> getMenuModulByUsername() async {
    final username = await Prefs.getString(Prefs.username);
    final url = '$kBaseUrl/tgrpo/tgrpo/api/getMenu/username=$username';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      if (data == null) return;
      print(data);

      final List<MenuModul> list = [];
      data.forEach((map) {
        list.add(MenuModul.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
