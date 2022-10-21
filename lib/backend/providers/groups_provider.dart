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
  List<Miembro>? miembros;

  String nombreInitiative = "";
  String descInitiative = "";
  String videoInitiative = "";
  String fileName = "";
  late Uint8List initiativeFile;

  Future<List<Group>> getGroups() async {
    final response = await http.get(Uri.parse(
        "${SystemData.ipServer}/api/users/groups/${SystemData.studentData?.idEstudiante ?? '0'}"));

    return GroupsList.fromJson(jsonDecode(response.body)).user ?? <Group>[];
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

    final members =
        MiembrosList.fromJson(jsonDecode(response.body)).miembrosGrupo ??
            <Miembro>[];
    miembros = members;
    return members;
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
    miembros?.forEach((e) {
      if (e.idEstudiante == idStudent) {
        repeatedMember = true;
        return;
      }
    });

    if (miembros == null || miembros!.isEmpty || repeatedMember) {
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

  Future<void> requestLeader() async {}

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
}
