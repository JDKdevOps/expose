class InboxList {
  List<Inbox>? contactMessages;

  InboxList({this.contactMessages});

  InboxList.fromJson(Map<String, dynamic> json) {
    if (json['contactMessages'] != null) {
      contactMessages = <Inbox>[];
      json['contactMessages'].forEach((v) {
        contactMessages!.add(Inbox.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contactMessages != null) {
      data['contactMessages'] =
          contactMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inbox {
  String? meTitulo;
  String? meFecha;
  String? meHora;
  String? meContenido;
  String? fkIdUsuario;
  String? iniNombre;

  Inbox(
      {this.meTitulo,
      this.meFecha,
      this.meHora,
      this.meContenido,
      this.fkIdUsuario,
      this.iniNombre});

  Inbox.fromJson(Map<String, dynamic> json) {
    meTitulo = json['me_titulo'];
    meFecha = json['me_fecha'];
    meHora = json['me_hora'];
    meContenido = json['me_contenido'];
    fkIdUsuario = json['fk_id_usuario'];
    iniNombre = json['ini_nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['me_titulo'] = meTitulo;
    data['me_fecha'] = meFecha;
    data['me_hora'] = meHora;
    data['me_contenido'] = meContenido;
    data['fk_id_usuario'] = fkIdUsuario;
    data['ini_nombre'] = iniNombre;
    return data;
  }
}
