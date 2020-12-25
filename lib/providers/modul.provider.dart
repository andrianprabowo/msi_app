import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msi_app/models/modul.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';

class ModulProvider with ChangeNotifier {
  List<Modul> _items;

  List<Modul> get items => _items;

  Future<void> getModulByUsername() async {
    final username = await Prefs.getString(Prefs.username);
    final url = '$kBaseUrl/tgrpo/tgrpo/api/modul/username=$username';

    try {
      final response = await http.get(url);
      print(response.request);
      final data = json.decode(response.body) as List;
      if (data == null) return;
      print(data);

      final List<Modul> list = [];
      data.forEach((map) {
        list.add(Modul.fromMap(map));
      });

      _items = list;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
