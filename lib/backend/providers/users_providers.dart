import 'dart:convert';

import 'package:expose_master/backend/classes/user_data.dart';
import 'package:expose_master/backend/classes/users.dart';
import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/services/local_storage.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends ChangeNotifier {
  int _index = 0;
  bool empty = false;

  int get index => _index;
  set index(e) {
    _index = e;
    notifyListeners();
  }

  GlobalKey<FormState> regForm = GlobalKey<FormState>();
  String? regCorreo = "";
  String regClave = "";
  String regNombre = "";
  String regApellidoPaterno = "";
  String regApellidoMaterno = "";
  String regFechaNacimiento = "";
  String regPromedio = "";
  String regFacultad = "";
  String regSemestre = "";

  GlobalKey<FormState> editForm = GlobalKey<FormState>();
  String? edCorreo;
  String? edgClave;
  String? edgClaveRepeat;
  String? edNombre;
  String? edApellidoPaterno;
  String? edApellidoMaterno;
  String? edFechaNacimiento;
  String? edIdEstudiante;
  String? edPromedio;
  String? edFacultad;
  String? edSemestre;

  Future<List<Users>> getUsers() async {
    var response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/users/page/$index"));

    final users =
        UsersList.fromJson(jsonDecode(response.body)).users ?? <Users>[];

    users.sort(
      (a, b) {
        if (a.fkIdEstado == 1) {
          return 1;
        }
        return -1;
      },
    );

    return users;
  }

  Future<bool> updateUser(String correo, int state) async {
    var response = await http.put(
      Uri.parse("${SystemData.ipServer}/api/users/updateStatus/$correo"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({"estado": state}),
    );
    notifyListeners();
    return jsonDecode(response.body)["result"] ?? false;
  }

  Future<SingleUser> getUserInfo(String id) async {
    var response = await http.get(
      Uri.parse("${SystemData.ipServer}/api/users/info/user/$id"),
    );

    return UserData.fromJson(jsonDecode(response.body)).user!.first;
  }

  //Función para registrar usuario persona
  Future<bool> register(int? customUserType) async {
    final response = await http.post(
      Uri.parse("${SystemData.ipServer}/api/users/add"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({
        "nombres": regNombre,
        "apellido_paterno": regApellidoPaterno,
        "apellido_materno": regApellidoMaterno,
        "fecha_nacimiento": regFechaNacimiento,
        "correo": regCorreo,
        "contrasenia": regClave,
        "tipo_usuario": customUserType ?? 1
      }),
    );

    notifyListeners();
    return jsonDecode(response.body)["result"] ?? false;
  }

  //UpdateUser
  Future<bool> updateUserData() async {
    final response = await http.put(
      Uri.parse(
          "${SystemData.ipServer}/api/users/updatePersonInfo/${SystemData.userData!.fkIdPersona}"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({
        "nombres": edNombre ?? SystemData.userData!.peNombres,
        "apellido_paterno":
            edApellidoPaterno ?? SystemData.userData!.peApellidoPaterno,
        "apellido_materno":
            edApellidoMaterno ?? SystemData.userData!.peApellidoMaterno,
        "fecha_nacimiento":
            edFechaNacimiento ?? SystemData.userData!.peFechaNacimiento
      }),
    );

    final result = jsonDecode(response.body)["result"] ?? false;
    if (result) {
      //student data update?
      if (SystemData.studentData != null) {
        final response1 = await http.put(
          Uri.parse(
              "${SystemData.ipServer}/api/users/updateStudentInfo/${SystemData.studentData!.idEstudiante}"),
          headers: {"content-type": "application/json; charset=utf-8"},
          body: jsonEncode({
            "promedio_ponderado":
                edPromedio ?? SystemData.studentData!.estPromedioPonderado,
            "fk_id_semestre":
                edSemestre ?? SystemData.studentData!.semNumeroSemestre,
            "fk_id_facultad":
                edFacultad ?? SystemData.studentData!.facNombreFacultad
          }),
        );

        final result1 = jsonDecode(response1.body)["result"] ?? false;
        if (result1) {
          return true;
        }
        return false;
      }

      return true;
    }
    return false;
  }
}
