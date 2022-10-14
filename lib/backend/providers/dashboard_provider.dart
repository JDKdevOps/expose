import 'dart:convert';
import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/classes/iniciativas_preview.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardProvider extends ChangeNotifier {
  int _indexPreview = 0;
  String findIniciative = "";

  int get indexPreview => _indexPreview;
  set indexPreview(e) {
    _indexPreview = e;
    notifyListeners();
  }

  Future<IniciativasPeview> getIniciativasPreview() async {
    var response = await http.get(
        Uri.parse("${SystemData.ipServer}/api/initiatives/page/$indexPreview"));

    var list = IniciativasPeview.fromJson(jsonDecode(response.body));
    return list;
  }

  Future<Iniciativa> findIniciativa() async {
    var response = await http.get(
        Uri.parse("${SystemData.ipServer}/api/initiatives/$findIniciative"));

    var list = Iniciativa.fromJson(jsonDecode(response.body));
    return list;
  }
}