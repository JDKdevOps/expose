class LeadersList {
  List<Leader>? user;

  LeadersList({this.user});

  LeadersList.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <Leader>[];
      json['user'].forEach((v) {
        user!.add(Leader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leader {
  int? idEstudiante;
  String? idUsuarioCorreo;
  double? estPromedioPonderado;
  String? peNombres;
  String? peApellidoPaterno;
  String? peApellidoMaterno;
  String? peFechaNacimiento;
  String? facNombreFacultad;
  int? semNumeroSemestre;

  Leader(
      {this.idEstudiante,
      this.idUsuarioCorreo,
      this.estPromedioPonderado,
      this.peNombres,
      this.peApellidoPaterno,
      this.peApellidoMaterno,
      this.peFechaNacimiento,
      this.facNombreFacultad,
      this.semNumeroSemestre});

  Leader.fromJson(Map<String, dynamic> json) {
    idEstudiante = json['id_estudiante'];
    idUsuarioCorreo = json['id_usuario_correo'];
    estPromedioPonderado = json['est_promedio_ponderado'];
    peNombres = json['pe_nombres'];
    peApellidoPaterno = json['pe_apellido_paterno'];
    peApellidoMaterno = json['pe_apellido_materno'];
    peFechaNacimiento = json['pe_fecha_nacimiento'];
    facNombreFacultad = json['fac_nombre_facultad'];
    semNumeroSemestre = json['sem_numero_semestre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_estudiante'] = idEstudiante;
    data['id_usuario_correo'] = idUsuarioCorreo;
    data['est_promedio_ponderado'] = estPromedioPonderado;
    data['pe_nombres'] = peNombres;
    data['pe_apellido_paterno'] = peApellidoPaterno;
    data['pe_apellido_materno'] = peApellidoMaterno;
    data['pe_fecha_nacimiento'] = peFechaNacimiento;
    data['fac_nombre_facultad'] = facNombreFacultad;
    data['sem_numero_semestre'] = semNumeroSemestre;
    return data;
  }
}
