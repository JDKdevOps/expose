import 'dart:convert';

import 'package:expose/backend/classes/groups.dart';
import 'package:expose/backend/classes/inbox.dart';
import 'package:expose/backend/classes/iniciativa_group.dart';
import 'package:expose/backend/classes/members.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class GroupsProvider extends ChangeNotifier {
  String addMiembro = "";
  List<Miembro> miembros = [];
  List<Group> grupos = [];

  String nombreInitiative = "";
  String descInitiative = "";
  String videoInitiative = "";
  String fileName = "";
  late Uint8List initiativeFile;

  String studentId = "";
  double studentPromedio = 0;
  int studentFacultad = 0;
  int studentSemestre = 0;

  String groupName = "";

  Future<bool> registerGroup() async {
    bool repeatedGroup = false;
    for (var element in grupos) {
      if (element.gruNombre == groupName) {
        repeatedGroup = true;
        continue;
      }
    }

    if (repeatedGroup) {
      return false;
    }
    await http.post(
      Uri.parse("${SystemData.ipServer}/api/groups/add"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({
        "nombre": groupName,
        "fk_id_estudiante": SystemData.studentData!.idEstudiante
      }),
    );

    final response = await http.get(Uri.parse(
        "${SystemData.ipServer}/api/groups/leaderGroup/${SystemData.studentData!.idEstudiante}"));

    final int idGroup =
        (jsonDecode(response.body)["LeaderGroup"] as List).last["id_grupo"]!;

    final response1 =
        await addMember(idGroup, SystemData.studentData!.idEstudiante!);

    return response1;
  }

  Future<List<Group>> getGroups() async {
    final response = await http.get(Uri.parse(
        "${SystemData.ipServer}/api/users/groups/${SystemData.studentData?.idEstudiante ?? '0'}"));
    grupos = GroupsList.fromJson(jsonDecode(response.body)).user ?? <Group>[];
    return grupos;
  }

  Future<List<InitiativeGroup>> getInitiativesGroup(int idGroup) async {
    final response = await http.get(
        Uri.parse("${SystemData.ipServer}/api/initiatives/group/$idGroup"));

    return InitiativeGroupList.fromJson(jsonDecode(response.body)).initiative ??
        <InitiativeGroup>[];
  }

  Future<List<Miembro>> getMembers(int idGroup) async {
    final response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/groups/members/$idGroup"));

    print(jsonDecode(response.body));

    return MiembrosList.fromJson(jsonDecode(response.body)).miembrosGrupo ??
        <Miembro>[];
  }

  Future<void> removeMember(int idGroup, int idStudent) async {
    await http.delete(
        Uri.parse("${SystemData.ipServer}/api/groups/members/delete"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: jsonEncode(
            {"fk_id_estudiante": idStudent, "fk_id_grupo": idGroup}));

    notifyListeners();
  }

  Future<bool> addMember(int idGroup, int idStudent) async {
    bool repeatedMember = false;
    for (var e in miembros) {
      if (e.idEstudiante == idStudent) {
        repeatedMember = true;
        continue;
      }
    }

    if (repeatedMember) {
      return false;
    }

    final response = await http.post(
        Uri.parse("${SystemData.ipServer}/api/groups/members/add"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: jsonEncode(
            {"fk_id_estudiante": idStudent, "fk_id_grupo": idGroup}));

    final result = jsonDecode(response.body);

    notifyListeners();

    return result["result"] ?? false;
  }

  Future<bool> requestLeader() async {
    final response = await http.put(
      Uri.parse(
          "${SystemData.ipServer}/api/users/updateStudentStatus/${SystemData.studentData!.idEstudiante}"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({"es_lider": 2}),
    );
    notifyListeners();
    return jsonDecode(response.body)["result"] ?? false;
  }

  Future<void> addInitiative(int idGroup) async {
    final storageReference = SystemData.firebaseStorage.ref().child(fileName);
    final uploadFile = storageReference.putData(initiativeFile);
    final fileURL = await uploadFile;
    final initiativeURL = await fileURL.ref.getDownloadURL();

    await http.post(Uri.parse("${SystemData.ipServer}/api/initiatives/add"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: jsonEncode({
          "nombre": nombreInitiative,
          "descripcion": descInitiative,
          "video": videoInitiative,
          "diapositiva": initiativeURL,
          "grupo": idGroup
        }));
  }

  Future<List<Inbox>> getInbox(int idGroup) async {
    final response = await http.get(
      Uri.parse("${SystemData.ipServer}/api/groups/contactMessages/$idGroup"),
    );

    return InboxList.fromJson(jsonDecode(response.body)).contactMessages ??
        <Inbox>[];
  }

  Future<bool> registerSutent() async {
    final response = await http.post(
        Uri.parse("${SystemData.ipServer}/api/users/addStudent"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: jsonEncode({
          "id": studentId,
          "promedio_ponderado": studentPromedio,
          "fk_id_persona": SystemData.userData!.fkIdPersona,
          "fk_id_facultad": studentFacultad,
          "fk_id_semestre": studentSemestre
        }));

    final request = jsonDecode(response.body)["result"] ?? false;

    if (request) {
      await http.put(
        Uri.parse(
            "${SystemData.ipServer}/api/users/updateType/${SystemData.userData!.idUsuarioCorreo!}"),
      );
      notifyListeners();
    }
    return request;
  }
}
