import 'dart:convert';
import 'package:expose_master/backend/classes/groups.dart';
import 'package:expose_master/backend/classes/inbox.dart';
import 'package:expose_master/backend/classes/iniciativa_group.dart';
import 'package:expose_master/backend/classes/members.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class GroupsProvider extends ChangeNotifier {
  //Controladores para los grupos general
  List<Group> grupos = [];

  //Controladores para crear iniciativas
  GlobalKey<FormState> newInitiativeKey = GlobalKey<FormState>();
  TextEditingController fileController = TextEditingController();
  String nombreInitiative = "";
  String descInitiative = "";
  String videoInitiative = "";
  String fileName = "";
  late Uint8List initiativeFile;

  //Controladores para miembros
  List<Miembro> miembros = [];
  GlobalKey<FormState> miembrosForm = GlobalKey<FormState>();
  String addMiembro = "";

  //Controladores para crear grupos
  GlobalKey<FormState> createGroupForm = GlobalKey<FormState>();
  String groupName = "";

  //Función para traer los grupos
  Future<List<Group>> getGroups() async {
    final response = await http.get(Uri.parse(
        "${SystemData.ipServer}/api/users/groups/${SystemData.studentData?.idEstudiante ?? '0'}"));
    grupos = GroupsList.fromJson(jsonDecode(response.body)).user ?? <Group>[];

    grupos.sort(
      (a, b) {
        if (b.lider == SystemData.studentData!.idEstudiante) {
          return 1;
        }
        return -1;
      },
    );

    return grupos;
  }

  //Función para eliminar un grupo
  Future<void> deleteGroup(int idGroup) async {
    await http.put(
        Uri.parse("${SystemData.ipServer}/api/groups/updateStatus/$idGroup"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: jsonEncode({"fk_id_estado": 4}));
    notifyListeners();
  }

  //Función para crear un grupo
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

  //Función para crear iniciativas
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

  //Función para ver iniciativas del grupo
  Future<List<InitiativeGroup>> getInitiativesGroup(int idGroup) async {
    final response = await http.get(
        Uri.parse("${SystemData.ipServer}/api/initiatives/group/$idGroup"));

    return InitiativeGroupList.fromJson(jsonDecode(response.body)).initiative ??
        <InitiativeGroup>[];
  }

  //Función para obtener miembros del grupo
  Future<List<Miembro>> getMembers(int idGroup) async {
    final response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/groups/members/$idGroup"));

    return MiembrosList.fromJson(jsonDecode(response.body)).miembrosGrupo ??
        <Miembro>[];
  }

  //Función para añadir miembro al grupo
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

  //Función para eliminar miembros del grupo
  Future<void> removeMember(int idGroup, int idStudent) async {
    await http.delete(
        Uri.parse("${SystemData.ipServer}/api/groups/members/delete"),
        headers: {"content-type": "application/json; charset=utf-8"},
        body: jsonEncode(
            {"fk_id_estudiante": idStudent, "fk_id_grupo": idGroup}));

    notifyListeners();
  }

  //Función para ver los mensajes del grupo
  Future<List<Inbox>> getInbox(int idGroup) async {
    final response = await http.get(
      Uri.parse("${SystemData.ipServer}/api/groups/contactMessages/$idGroup"),
    );

    return InboxList.fromJson(jsonDecode(response.body)).contactMessages ??
        <Inbox>[];
  }

  //Función para solicitar liderazgo
  Future<bool> requestLeader() async {
    final response = await http.put(
      Uri.parse(
          "${SystemData.ipServer}/api/users/updateStudentStatus/${SystemData.studentData!.idEstudiante}"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({"es_lider": 2}),
    );
    return jsonDecode(response.body)["result"] ?? false;
  }
}
