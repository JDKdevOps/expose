import 'dart:convert';
import 'package:expose/backend/classes/comments.dart';
import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InitiativesProvider extends ChangeNotifier {
  int _indexPreview = 0;
  String findIniciative = "";

  String comment = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String titulo = "";
  String contenido = "";

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

  Future<double> getRating(String id) async {
    final response = await SystemData.userRating
        .where("user", isEqualTo: SystemData.userData!.idUsuarioCorreo)
        .where("initiativeId", isEqualTo: id)
        .get()
      ..docs;

    if (response.docs.isNotEmpty) {
      return response.docs.first["value"] as double;
    }
    return 0;
  }

  Future<void> updateRating(int id, double value) async {
    final response0 = await SystemData.userRating
        .where("initiativeId", isEqualTo: id.toString())
        .where("user", isEqualTo: SystemData.userData!.idUsuarioCorreo)
        .get()
      ..docs;

    if (response0.docs.isEmpty) {
      await SystemData.userRating.add({
        "initiativeId": id.toString(),
        "user": SystemData.userData!.idUsuarioCorreo,
        "value": value
      });
    } else {
      await SystemData.userRating
          .doc(response0.docs.first.id)
          .update({"value": value});
    }

    final response = await SystemData.userRating
        .where("initiativeId", isEqualTo: id.toString())
        .get()
      ..docs;

    double newRating = 0;
    for (var e in response.docs) {
      newRating += e["value"];
    }

    newRating /= response.docs.length;
    final body = jsonEncode({"calificacion": newRating});
    await http.put(
        Uri.parse("${SystemData.ipServer}/api/initiatives/updateRating/$id"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: body);

    notifyListeners();
  }

  Future<List<Comments>> getComments(String id) async {
    final response =
        await SystemData.userComments.where("initiativeId", isEqualTo: id).get()
          ..docs;
    late List<Comments> list = [];

    for (var e in response.docs) {
      var json = {
        "content": e["content"],
        "timestamp": e["timestamp"],
        "email": e["email"],
        "name": e["name"],
        "initiativeId": e["initiativeId"],
      };

      list.add(Comments.fromJson(json));
    }

    return list;
  }

  Future<void> postComments(String id) async {
    final timestamp = DateTime.now();

    await SystemData.userComments.add({
      "content": comment,
      "timestamp":
          "${timestamp.year}-${timestamp.month}-${timestamp.day}-${timestamp.hour}:${timestamp.minute}:${timestamp.second}",
      "email": SystemData.userData!.idUsuarioCorreo,
      "name": SystemData.userData!.peNombres,
      "initiativeId": id,
    });

    notifyListeners();
  }

  Future<void> sendInitiativeMessage(int id) async {
    final timestamp = DateTime.now();

    final body = jsonEncode({
      "titulo": titulo,
      "contenido": contenido,
      "fecha": "${timestamp.year}-${timestamp.month}-${timestamp.day}",
      "hora": "${timestamp.hour}:${timestamp.minute}:${timestamp.second}",
      "fk_id_usuario": SystemData.userData!.idUsuarioCorreo,
      "fk_id_iniciativa": id
    });

    await http.post(
        Uri.parse("${SystemData.ipServer}/api/initiatives/message/add"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: body);
  }
}
