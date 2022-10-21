import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expose/backend/classes/student_data.dart';
import 'package:expose/backend/classes/user_data.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/backend/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  String regName = "";
  String regApellidoMaterno = "";
  String regApellidoPaterno = "";
  String regFechaNacimiento = "";
  String regCorreo = "";
  String regPasswd = "";

  AuthProvider() {
    isAuthenticated();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.localDB.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    late List<QueryDocumentSnapshot<Object?>> response;
    await SystemData.userSesions
        .where('tokenId', isEqualTo: token)
        .get()
        .then((value) => response = value.docs);
    if (response.isNotEmpty && response.first["tokenId"] == token) {
      if (SystemData.userData == null) {
        await login(response.first["correo"], response.first["password"]);
      }
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    }

    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    return false;
  }

  bool validateLogin() {
    if (loginKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    //Get UserData
    var response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/users/info/user/$email"));

    var user = UserData.fromJson(jsonDecode(response.body)).user;
    if (user!.isNotEmpty &&
        user.first.estNombreEstado == "active" &&
        user.first.usuContrasenia == password) {
      //Parse userData and DateTimes
      SystemData.userData = user.first;
      var parseDate = DateTime.parse(SystemData.userData!.peFechaNacimiento!);
      SystemData.userData!.peFechaNacimiento =
          "${parseDate.year}-${parseDate.month}-${parseDate.day}";

      //Check if user is type Student
      if (SystemData.userData!.tipTipoUsuario == "Estudiante") {
        response = await http.get(Uri.parse(
            "${SystemData.ipServer}/api/users/info/student/${SystemData.userData!.fkIdPersona}"));
        SystemData.studentData =
            StudentData.fromJson(jsonDecode(response.body)).user!.first;
      }
      //Register Sesion in NoSQL
      late String tokenId;
      await tokenGenerator().then((value) => tokenId = value);
      var noSQL = {
        "tokenId": tokenId,
        "correo": SystemData.userData!.idUsuarioCorreo,
        "password": SystemData.userData!.usuContrasenia,
        "tipo_usuario": SystemData.userData!.tipTipoUsuario,
        "apellido1": SystemData.userData!.peApellidoPaterno,
        "apellido2": SystemData.userData!.peApellidoMaterno,
        "fecha_nacimiento": SystemData.userData!.peFechaNacimiento,
        "id_persona": SystemData.userData!.fkIdPersona,
        "id_estudiante": SystemData.studentData?.idEstudiante,
        "promedio_ponderado": SystemData.studentData?.estPromedioPonderado,
        "es_lider": SystemData.studentData?.estEsLider,
        "facultad": SystemData.studentData?.facNombreFacultad,
        "semestre": SystemData.studentData?.semNumeroSemestre,
      };
      late List<QueryDocumentSnapshot<Object?>> noSQLresponse;
      await SystemData.userSesions
          .where("correo", isEqualTo: SystemData.userData!.idUsuarioCorreo)
          .get()
          .then((value) => noSQLresponse = value.docs);
      if (noSQLresponse.isEmpty) {
        SystemData.userSesions.add(noSQL);
      } else {
        SystemData.userSesions.doc(noSQLresponse.first.id).update(noSQL);
      }

      //Guardar token de sesión local
      LocalStorage.localDB.setString('token', tokenId);
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> register() async {
    final response = await http.post(
      Uri.parse("${SystemData.ipServer}/api/users/add"),
      headers: {"content-type": "application/json; charset=utf-8"},
      body: jsonEncode({
        "nombres": regName,
        "apellido_paterno": regApellidoPaterno,
        "apellido_materno": regApellidoMaterno,
        "fecha_nacimiento": regFechaNacimiento,
        "correo": regCorreo,
        "contrasenia": regPasswd,
        "tipo_usuario": 1
      }),
    );

    return jsonDecode(response.body)["result"] ?? false;
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

Future<String> tokenGenerator() async {
  var response = await http
      .get(Uri.parse("https://www.uuidtools.com/api/generate/timestamp-first"));
  return response.body.substring(2, response.body.length - 2);
}
