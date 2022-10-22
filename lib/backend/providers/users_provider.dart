import 'dart:convert';

import 'package:expose/backend/classes/users.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends ChangeNotifier {
  int _indexPreview = 0;
  bool emptyContent = false;

  int get indexPreview => _indexPreview;
  set indexPreview(e) {
    _indexPreview = e;
    notifyListeners();
  }

  Future<List<Users>> getUsers() async {
    var response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/users/page/$indexPreview"));

    return UsersList.fromJson(jsonDecode(response.body)).users ?? <Users>[];
  }

  Future<bool> updateUser(String correo, int state) async {
    var response = await http.put(
      Uri.parse("${SystemData.ipServer}/api/users/updateStatus/$correo"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({"estado": state}),
    );
    notifyListeners();
    return jsonDecode(response.body)["result"] ?? false;
  }
}
