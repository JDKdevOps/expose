class InitiativeGroupList {
  List<InitiativeGroup>? initiative;

  InitiativeGroupList({this.initiative});

  InitiativeGroupList.fromJson(Map<String, dynamic> json) {
    if (json['initiative'] != null) {
      initiative = <InitiativeGroup>[];
      json['initiative'].forEach((v) {
        initiative!.add(InitiativeGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (initiative != null) {
      data['initiative'] = initiative!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InitiativeGroup {
  int? idIniciativa;
  String? iniNombre;
  double? iniCalificacionPromedio;
  String? iniVideo;
  String? iniDescripcion;
  String? iniDiapositiva;
  String? estNombreEstado;

  InitiativeGroup(
      {this.idIniciativa,
      this.iniNombre,
      this.iniCalificacionPromedio,
      this.iniVideo,
      this.iniDescripcion,
      this.iniDiapositiva,
      this.estNombreEstado});

  InitiativeGroup.fromJson(Map<String, dynamic> json) {
    idIniciativa = json['id_iniciativa'];
    iniNombre = json['ini_nombre'];
    iniCalificacionPromedio = json['ini_calificacion_promedio'];
    iniVideo = json['ini_video'];
    iniDescripcion = json['ini_descripcion'];
    iniDiapositiva = json['ini_diapositiva'];
    estNombreEstado = json['est_nombre_estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_iniciativa'] = idIniciativa;
    data['ini_nombre'] = iniNombre;
    data['ini_calificacion_promedio'] = iniCalificacionPromedio;
    data['ini_video'] = iniVideo;
    data['ini_descripcion'] = iniDescripcion;
    data['ini_diapositiva'] = iniDiapositiva;
    data['est_nombre_estado'] = estNombreEstado;
    return data;
  }
}
