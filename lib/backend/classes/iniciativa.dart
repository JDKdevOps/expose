class InitiativesList {
  List<Initiative>? initiatives;

  InitiativesList({this.initiatives});

  InitiativesList.fromJson(Map<String, dynamic> json) {
    if (json['initiatives'] != null) {
      initiatives = <Initiative>[];
      json['initiatives'].forEach((v) {
        initiatives!.add(Initiative.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (initiatives != null) {
      data['initiatives'] = initiatives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Initiative {
  int? idIniciativa;
  String? iniNombre;
  String? iniDescripcion;
  double? iniCalificacionPromedio;
  String? iniDiapositiva;
  String? iniVideo;
  String? gruNombre;

  Initiative(
      {this.idIniciativa,
      this.iniNombre,
      this.iniDescripcion,
      this.iniCalificacionPromedio,
      this.iniDiapositiva,
      this.iniVideo,
      this.gruNombre});

  Initiative.fromJson(Map<String, dynamic> json) {
    idIniciativa = json['id_iniciativa'];
    iniNombre = json['ini_nombre'];
    iniDescripcion = json['ini_descripcion'];
    iniCalificacionPromedio = json['ini_calificacion_promedio'];
    iniDiapositiva = json['ini_diapositiva'];
    iniVideo = json['ini_video'];
    gruNombre = json['gru_nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_iniciativa'] = idIniciativa;
    data['ini_nombre'] = iniNombre;
    data['ini_descripcion'] = iniDescripcion;
    data['ini_calificacion_promedio'] = iniCalificacionPromedio;
    data['ini_diapositiva'] = iniDiapositiva;
    data['ini_video'] = iniVideo;
    data['gru_nombre'] = gruNombre;
    return data;
  }
}
