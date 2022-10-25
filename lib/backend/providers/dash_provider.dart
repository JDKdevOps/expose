import 'dart:convert';
import 'package:expose_master/backend/classes/comments.dart';
import 'package:expose_master/backend/classes/iniciativa.dart';
import 'package:expose_master/backend/router/router_manager.dart';
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

  //Lista para controlar las calificaciones (onlyAuth)
  List<InitiativeRating> ratingList = [];

  //Controlador para la caja de comentarios
  String comment = "";
  GlobalKey<FormState> commentsForm = GlobalKey<FormState>();
  TextEditingController commentsController = TextEditingController();

  //Funcion para obtener las iniciativas
  Future<List<Initiative>> getIniciativas() async {
    var response = await http.get(
      Uri.parse("${SystemData.ipServer}/api/initiatives/page/$_index"),
    );

    final result = InitiativesList.fromJson(
          jsonDecode(response.body),
        ).initiatives ??
        <Initiative>[];

    //Si está autenticado, cargar sus calificaciones a las iniciativas
    if (RouterBuilderManager.routerStatus == RouterStatus.auth) {
      for (var element in result) {
        ratingList.add(
          InitiativeRating(
            initiative: element.idIniciativa!.toString(),
            value: await getRating(
              element.idIniciativa!.toString(),
            ),
          ),
        );
      }
    }

    return result;
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
}

class InitiativeRating {
  late String initiative;
  late double value;

  InitiativeRating({required this.initiative, required this.value});
}
