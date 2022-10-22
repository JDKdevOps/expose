class MiembrosList {
  List<Miembro>? miembrosGrupo;

  MiembrosList({this.miembrosGrupo});

  MiembrosList.fromJson(Map<String, dynamic> json) {
    if (json['miembrosGrupo'] != null) {
      miembrosGrupo = <Miembro>[];
      json['miembrosGrupo'].forEach((v) {
        miembrosGrupo!.add(new Miembro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.miembrosGrupo != null) {
      data['miembrosGrupo'] =
          this.miembrosGrupo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Miembro {
  int? idEstudiante;
  double? estPromedioPonderado;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_estudiante'] = this.idEstudiante;
    data['est_promedio_ponderado'] = this.estPromedioPonderado;
    data['est_es_lider'] = this.estEsLider;
    data['pe_nombres'] = this.peNombres;
    data['pe_apellido_paterno'] = this.peApellidoPaterno;
    data['pe_apellido_materno'] = this.peApellidoMaterno;
    return data;
  }
}
