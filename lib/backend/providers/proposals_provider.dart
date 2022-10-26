import 'dart:convert';

import 'package:expose_master/backend/classes/iniciativa.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProposalsProvider extends ChangeNotifier {
  //Controladores para la paginación de las iniciativas
  int _index = 0;
  bool empty = false;
  int get index => _index;
  set index(e) {
    _index = e;
    notifyListeners();
  }

  Future<List<Initiative>> getIniciativas() async {
    var response = await http.get(Uri.parse(
        "${SystemData.ipServer}/api/initiatives/pending/page/$index"));

    return InitiativesList.fromJson(jsonDecode(response.body)).initiatives ??
        <Initiative>[];
  }

  Future<bool> updateIniciative(int id, int state) async {
    var response = await http.put(
      Uri.parse("${SystemData.ipServer}/api/initiatives/updateStatus/$id"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode(
        {"status": state},
      ),
    );
    notifyListeners();
    return jsonDecode(response.body)["result"] ?? false;
  }
}
