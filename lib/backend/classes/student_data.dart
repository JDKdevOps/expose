class StudentData {
  List<SingleStudent>? user;

  StudentData({this.user});

  StudentData.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <SingleStudent>[];
      json['user'].forEach((v) {
        user!.add(SingleStudent.fromJson(v));
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

class SingleStudent {
  int? idEstudiante;
  double? estPromedioPonderado;
  int? estEsLider;
  String? facNombreFacultad;
  int? semNumeroSemestre;

  SingleStudent(
      {this.idEstudiante,
      this.estPromedioPonderado,
      this.estEsLider,
      this.facNombreFacultad,
      this.semNumeroSemestre});

  SingleStudent.fromJson(Map<String, dynamic> json) {
    idEstudiante = json['id_estudiante'];
    estPromedioPonderado = json['est_promedio_ponderado'];
    estEsLider = json['est_es_lider'];
    facNombreFacultad = json['fac_nombre_facultad'];
    semNumeroSemestre = json['sem_numero_semestre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_estudiante'] = idEstudiante;
    data['est_promedio_ponderado'] = estPromedioPonderado;
    data['est_es_lider'] = estEsLider;
    data['fac_nombre_facultad'] = facNombreFacultad;
    data['sem_numero_semestre'] = semNumeroSemestre;
    return data;
  }
}
