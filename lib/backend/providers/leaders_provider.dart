import 'dart:convert';

import 'package:expose/backend/classes/leaders.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeadersProvider extends ChangeNotifier {
  Future<List<Leader>> getLeaders() async {
    print("xd");
    var response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/users/info/studentLeader"));
    print("xd2");
    print(LeadersList.fromJson(jsonDecode(response.body)).user);
    return LeadersList.fromJson(jsonDecode(response.body)).user ?? <Leader>[];
  }

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
