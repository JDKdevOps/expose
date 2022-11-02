import 'dart:convert';
import 'package:expose_master/backend/classes/comments.dart';
import 'package:expose_master/backend/classes/iniciativa.dart';
import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashProvider extends ChangeNotifier {
  //Controladores para la paginación de las iniciativas
  int _index = 0;
  bool empty = false;
  int get index => _index;
  set index(e) {
    _index = e;
    notifyListeners();
  }

  //Controlador para la caja de comentarios
  GlobalKey<FormState> commentsForm = GlobalKey<FormState>();
  String comment = "";

  //Controlador para el formulario de contacto
  GlobalKey<FormState> contactForm = GlobalKey<FormState>();
  String asunto = "";
  String contenido = "";

  //Funcion para obtener las iniciativas
  Future<List<Initiative>> getIniciativas(RouterStatus routerStatus) async {
    var response = await http.get(
      Uri.parse("${SystemData.ipServer}/api/initiatives/page/$_index"),
    );

    return InitiativesList.fromJson(
          jsonDecode(response.body),
        ).initiatives ??
        <Initiative>[];
  }

  //Función para obtener la calificación de las iniciativas
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

  //Función para calificar las iniciativas
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

  //Función para obtener comentarios
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
        "id": e.id
      };

      list.add(Comments.fromJson(json));
    }

    list.sort(
      (a, b) => b.timestamp.toString().compareTo(a.timestamp.toString()),
    );

    return list;
  }

  //Función para publicar comentarios
  Future<void> postComments(String id) async {
    await SystemData.userComments.add({
      "content": comment,
      "timestamp": DateTime.now(),
      "email": SystemData.userData!.idUsuarioCorreo,
      "name": SystemData.userData!.peNombres,
      "initiativeId": id,
    });

    notifyListeners();
  }

  //Función para eliminar comentarios
    Future<void> removeComment(String id) async {
    await SystemData.userComments.doc(id).delete();
    notifyListeners();
  }

  //Función para enviar formulario de contacto
  Future<void> sendInitiativeMessage(int id) async {
    final timestamp = DateTime.now();

    final body = jsonEncode({
      "titulo": asunto,
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

class InitiativeRating {
  late String initiative;
  late double value;

  InitiativeRating({required this.initiative, required this.value});
}
