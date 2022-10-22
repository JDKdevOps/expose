class UsersList {
  List<Users>? users;

  UsersList({this.users});

  UsersList.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? idUsuarioCorreo;
  int? fkIdEstado;
  int? fkIdTipoUsuario;
  int? fkIdPersona;

  Users(
      {this.idUsuarioCorreo,
      this.fkIdEstado,
      this.fkIdTipoUsuario,
      this.fkIdPersona});

  Users.fromJson(Map<String, dynamic> json) {
    idUsuarioCorreo = json['id_usuario_correo'];
    fkIdEstado = json['fk_id_estado'];
    fkIdTipoUsuario = json['fk_id_tipo_usuario'];
    fkIdPersona = json['fk_id_persona'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario_correo'] = idUsuarioCorreo;
    data['fk_id_estado'] = fkIdEstado;
    data['fk_id_tipo_usuario'] = fkIdTipoUsuario;
    data['fk_id_persona'] = fkIdPersona;
    return data;
  }
}
