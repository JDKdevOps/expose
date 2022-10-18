import 'dart:convert';
import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InitiativesProvider extends ChangeNotifier {
  int _indexPreview = 0;
  String findIniciative = "";

  int get indexPreview => _indexPreview;
  set indexPreview(e) {
    _indexPreview = e;
    notifyListeners();
  }

  Future<List<Initiatives>> getIniciativas() async {
    var response = await http.get(
        Uri.parse("${SystemData.ipServer}/api/initiatives/page/$indexPreview"));

    var list = Iniciativa.fromJson(jsonDecode(response.body)).initiatives;
    return list ?? <Initiatives>[];
  }

  Future<void> getRating(String index) async {
    final response = await SystemData.userRating
        .where("user", isEqualTo: SystemData.userData!.idUsuarioCorreo)
        .where("initiativeId", isEqualTo: index)
        .get()
      ..docs;
  }
}
