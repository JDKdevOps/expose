class LeadersList {
  List<Leader>? user;

  LeadersList({this.user});

  LeadersList.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <Leader>[];
      json['user'].forEach((v) {
        user!.add(new Leader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_estudiante'] = this.idEstudiante;
    data['id_usuario_correo'] = this.idUsuarioCorreo;
    data['est_promedio_ponderado'] = this.estPromedioPonderado;
    data['pe_nombres'] = this.peNombres;
    data['pe_apellido_paterno'] = this.peApellidoPaterno;
    data['pe_apellido_materno'] = this.peApellidoMaterno;
    data['pe_fecha_nacimiento'] = this.peFechaNacimiento;
    data['fac_nombre_facultad'] = this.facNombreFacultad;
    data['sem_numero_semestre'] = this.semNumeroSemestre;
    return data;
  }
}
