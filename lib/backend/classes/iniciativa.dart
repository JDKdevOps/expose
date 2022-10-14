class Iniciativa {
  List<Initiative>? initiative;

  Iniciativa({this.initiative});

  Iniciativa.fromJson(Map<String, dynamic> json) {
    if (json['initiative'] != null) {
      initiative = <Initiative>[];
      json['initiative'].forEach((v) {
        initiative!.add(Initiative.fromJson(v));
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

class Initiative {
  String? iniNombre;
  String? iniDescripcion;
  int? iniCalificacionPromedio;
  String? iniDiapositiva;
  String? iniVideo;
  String? estNombreEstado;
  String? gruNombre;

  Initiative(
      {this.iniNombre,
      this.iniDescripcion,
      this.iniCalificacionPromedio,
      this.iniDiapositiva,
      this.iniVideo,
      this.estNombreEstado,
      this.gruNombre});

  Initiative.fromJson(Map<String, dynamic> json) {
    iniNombre = json['ini_nombre'];
    iniDescripcion = json['ini_descripcion'];
    iniCalificacionPromedio = json['ini_calificacion_promedio'];
    iniDiapositiva = json['ini_diapositiva'];
    iniVideo = json['ini_video'];
    estNombreEstado = json['est_nombre_estado'];
    gruNombre = json['gru_nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ini_nombre'] = iniNombre;
    data['ini_descripcion'] = iniDescripcion;
    data['ini_calificacion_promedio'] = iniCalificacionPromedio;
    data['ini_diapositiva'] = iniDiapositiva;
    data['ini_video'] = iniVideo;
    data['est_nombre_estado'] = estNombreEstado;
    data['gru_nombre'] = gruNombre;
    return data;
  }
}
