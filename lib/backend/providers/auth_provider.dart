import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expose_master/backend/classes/student_data.dart';
import 'package:expose_master/backend/classes/user_data.dart';
import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/services/local_storage.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  RouterStatus routerStatus = RouterStatus.checking;
  AuthProvider() {
    isAuthenticated();
  }

  //Controladores para el inicio de sesión
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  String correo = "";
  String passwd = "";

  //Controladores para el registro de usuario persona
  GlobalKey<FormState> registerForm = GlobalKey<FormState>();
  bool _policy = false;
  bool get policy => _policy;
  set policy(e) {
    _policy = e;
    notifyListeners();
  }

  String regName = "";
  String regApellidoMaterno = "";
  String regApellidoPaterno = "";
  String regFechaNacimiento = "";
  String regCorreo = "";
  String regPasswd = "";

  //Controladores para el registro de estudiante
  GlobalKey<FormState> studentForm = GlobalKey<FormState>();
  String studentId = "";
  double studentPromedio = 0;
  int studentFacultad = 0;
  int studentSemestre = 0;

  //Función para verificar sesión
  Future<bool> isAuthenticated() async {
    final token = LocalStorage.localDB.getString('token');

    if (token == null) {
      routerStatus = RouterStatus.notAuth;
      notifyListeners();
      return false;
    }

    late List<QueryDocumentSnapshot<Object?>> response;
    await SystemData.userSesions
        .where('tokenId', isEqualTo: token)
        .get()
        .then((value) => response = value.docs);
    if (response.isNotEmpty && response.first.get("tokenId") == token) {
      SystemData.userData ??= SingleUser(
        fkIdPersona: response.first.get("id_persona"),
        peNombres: response.first.get("nombre"),
        peApellidoPaterno: response.first.get("apellido1"),
        peApellidoMaterno: response.first.get("apellido2"),
        peFechaNacimiento: response.first.get("fecha_nacimiento"),
        tipTipoUsuario: response.first.get("tipo_usuario"),
        estNombreEstado: "active",
        idUsuarioCorreo: response.first.get("correo"),
        usuContrasenia: response.first.get("password"),
      );

      if (response.first["tipo_usuario"] == "Estudiante") {
        SystemData.studentData ??= SingleStudent(
          idEstudiante: response.first.get("id_estudiante"),
          estEsLider: response.first.get("es_lider"),
          estPromedioPonderado: response.first.get("promedio_ponderado"),
          facNombreFacultad: response.first.get("facultad"),
          semNumeroSemestre: response.first.get("semestre"),
        );
      }
      notifyListeners();
      routerStatus = RouterStatus.auth;
      return true;
    }
    notifyListeners();
    routerStatus = RouterStatus.notAuth;
    return false;
  }

  //Función para iniciar sesión
  Future<bool> login() async {
    //Get UserData
    var response = await http
        .get(Uri.parse("${SystemData.ipServer}/api/users/info/user/$correo"));

    var user = UserData.fromJson(jsonDecode(response.body)).user;
    if (user!.isNotEmpty &&
        user.first.estNombreEstado == "active" &&
        user.first.usuContrasenia == passwd) {
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
        "nombre": SystemData.userData!.peNombres,
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
      routerStatus = RouterStatus.auth;
      notifyListeners();
      return true;
    }

    return false;
  }

  //Función para registrar usuario persona
  Future<bool> register(int? customUserType) async {
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
        "tipo_usuario": customUserType ?? 1
      }),
    );
    return jsonDecode(response.body)["result"] ?? false;
  }

  //Función para registrar estudiante
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
    }
    return request;
  }

  //Función para cerrar sesión
  void logout() {
    LocalStorage.localDB.setString('token', "");
    routerStatus = RouterStatus.notAuth;
    notifyListeners();
    NavigationRouter.replaceTo(SystemRouter.root);
  }
}

//Función para generar token de autenticación
Future<String> tokenGenerator() async {
  var response = await http
      .get(Uri.parse("https://www.uuidtools.com/api/generate/timestamp-first"));
  return response.body.substring(2, response.body.length - 2);
}

//Estado de autenticación

enum RouterStatus { auth, notAuth, checking }
