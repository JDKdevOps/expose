class IniciativasPeview {
  List<Initiatives>? initiatives;

  IniciativasPeview({this.initiatives});

  IniciativasPeview.fromJson(Map<String, dynamic> json) {
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
  String? iniNombre;
  String? iniDescripcion;
  String? gruNombre;

  Initiatives({this.iniNombre, this.iniDescripcion, this.gruNombre});

  Initiatives.fromJson(Map<String, dynamic> json) {
    iniNombre = json['ini_nombre'];
    iniDescripcion = json['ini_descripcion'];
    gruNombre = json['gru_nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ini_nombre'] = iniNombre;
    data['ini_descripcion'] = iniDescripcion;
    data['gru_nombre'] = gruNombre;
    return data;
  }
}
