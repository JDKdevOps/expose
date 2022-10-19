class Messages {
  List<ContactMessage>? contactMessage;

  Messages({this.contactMessage});

  Messages.fromJson(Map<String, dynamic> json) {
    if (json['contactMessage'] != null) {
      contactMessage = <ContactMessage>[];
      json['contactMessage'].forEach((v) {
        contactMessage!.add(ContactMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contactMessage != null) {
      data['contactMessage'] = contactMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactMessage {
  String? meTitulo;
  String? meFecha;
  String? meHora;
  String? meContenido;
  String? fkIdUsuario;
  String? iniNombre;

  ContactMessage(
      {this.meTitulo,
      this.meFecha,
      this.meHora,
      this.meContenido,
      this.fkIdUsuario,
      this.iniNombre});

  ContactMessage.fromJson(Map<String, dynamic> json) {
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
