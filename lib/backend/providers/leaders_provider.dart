import 'dart:convert';

import 'package:expose_master/backend/classes/leaders.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeadersProvider extends ChangeNotifier {
  //Función para obtener líderes
  Future<List<Leader>> getLeaders() async {
    var response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/users/info/studentLeader"));

    return LeadersList.fromJson(jsonDecode(response.body)).user ?? <Leader>[];
  }

  //Función para aprobar líderes
  Future<bool> updateLeader(int id, int leaderType) async {
    final response = await http.put(
      Uri.parse("${SystemData.ipServer}/api/users/updateStudentStatus/$id"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({"es_lider": leaderType}),
    );
    notifyListeners();
    return jsonDecode(response.body)["result"] ?? false;
  }
}
