class MiembrosList {
  List<Miembro>? miembrosGrupo;

  MiembrosList({this.miembrosGrupo});

  MiembrosList.fromJson(Map<String, dynamic> json) {
    if (json['miembrosGrupo'] != null) {
      miembrosGrupo = <Miembro>[];
      json['miembrosGrupo'].forEach((v) {
        miembrosGrupo!.add(Miembro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (miembrosGrupo != null) {
      data['miembrosGrupo'] = miembrosGrupo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Miembro {
  int? idEstudiante;
  int? estPromedioPonderado;
  int? estEsLider;
  String? peNombres;
  String? peApellidoPaterno;
  String? peApellidoMaterno;

  Miembro(
      {this.idEstudiante,
      this.estPromedioPonderado,
      this.estEsLider,
      this.peNombres,
      this.peApellidoPaterno,
      this.peApellidoMaterno});

  Miembro.fromJson(Map<String, dynamic> json) {
    idEstudiante = json['id_estudiante'];
    estPromedioPonderado = json['est_promedio_ponderado'];
    estEsLider = json['est_es_lider'];
    peNombres = json['pe_nombres'];
    peApellidoPaterno = json['pe_apellido_paterno'];
    peApellidoMaterno = json['pe_apellido_materno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_estudiante'] = idEstudiante;
    data['est_promedio_ponderado'] = estPromedioPonderado;
    data['est_es_lider'] = estEsLider;
    data['pe_nombres'] = peNombres;
    data['pe_apellido_paterno'] = peApellidoPaterno;
    data['pe_apellido_materno'] = peApellidoMaterno;
    return data;
  }
}
