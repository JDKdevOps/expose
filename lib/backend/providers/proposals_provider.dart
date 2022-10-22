import 'dart:convert';

import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProposalsProvider extends ChangeNotifier {
  int _indexPreview = 0;
  bool emptyContent = false;

  int get indexPreview => _indexPreview;
  set indexPreview(e) {
    _indexPreview = e;
    notifyListeners();
  }

  Future<List<Initiative>> getIniciativas() async {
    var response = await http.get(Uri.parse(
        "${SystemData.ipServer}/api/initiatives/pending/page/$indexPreview"));

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
