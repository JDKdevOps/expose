class Iniciativa {
  List<Initiatives>? initiatives;

  Iniciativa({this.initiatives});

  Iniciativa.fromJson(Map<String, dynamic> json) {
    if (json['initiatives'] != null) {
      initiatives = <Initiatives>[];
      json['initiatives'].forEach((v) {
        initiatives!.add(Initiatives.fromJson(v));
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

class Initiatives {
  int? idIniciativa;
  String? iniNombre;
  String? iniDescripcion;
  double? iniCalificacionPromedio;
  String? iniDiapositiva;
  String? iniVideo;
  String? gruNombre;

  Initiatives(
      {this.idIniciativa,
      this.iniNombre,
      this.iniDescripcion,
      this.iniCalificacionPromedio,
      this.iniDiapositiva,
      this.iniVideo,
      this.gruNombre});

  Initiatives.fromJson(Map<String, dynamic> json) {
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
