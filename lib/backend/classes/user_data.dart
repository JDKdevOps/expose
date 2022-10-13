class UserData {
  List<SingleUser>? user;

  UserData({this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <SingleUser>[];
      json['user'].forEach((v) {
        user!.add(SingleUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleUser {
  String? idUsuarioCorreo;
  String? usuContrasenia;
  String? tipTipoUsuario;
  String? estNombreEstado;
  String? peNombres;
  String? peApellidoPaterno;
  String? peApellidoMaterno;
  String? peFechaNacimiento;
  int? fkIdPersona;

  SingleUser(
      {this.idUsuarioCorreo,
      this.usuContrasenia,
      this.tipTipoUsuario,
      this.estNombreEstado,
      this.peNombres,
      this.peApellidoPaterno,
      this.peApellidoMaterno,
      this.peFechaNacimiento,
      this.fkIdPersona});

  SingleUser.fromJson(Map<String, dynamic> json) {
    idUsuarioCorreo = json['id_usuario_correo'];
    usuContrasenia = json['usu_contrasenia'];
    tipTipoUsuario = json['tip_tipo_usuario'];
    estNombreEstado = json['est_nombre_estado'];
    peNombres = json['pe_nombres'];
    peApellidoPaterno = json['pe_apellido_paterno'];
    peApellidoMaterno = json['pe_apellido_materno'];
    peFechaNacimiento = json['pe_fecha_nacimiento'];
    fkIdPersona = json['fk_id_persona'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario_correo'] = idUsuarioCorreo;
    data['usu_contrasenia'] = usuContrasenia;
    data['tip_tipo_usuario'] = tipTipoUsuario;
    data['est_nombre_estado'] = estNombreEstado;
    data['pe_nombres'] = peNombres;
    data['pe_apellido_paterno'] = peApellidoPaterno;
    data['pe_apellido_materno'] = peApellidoMaterno;
    data['pe_fecha_nacimiento'] = peFechaNacimiento;
    data['fk_id_persona'] = fkIdPersona;
    return data;
  }
}
