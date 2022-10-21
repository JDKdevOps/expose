class GroupsList {
  List<Group>? user;

  GroupsList({this.user});

  GroupsList.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <Group>[];
      json['user'].forEach((v) {
        user!.add(Group.fromJson(v));
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

class Group {
  int? idGrupo;
  String? gruNombre;
  int? lider;

  Group({this.idGrupo, this.gruNombre, this.lider});

  Group.fromJson(Map<String, dynamic> json) {
    idGrupo = json['id_grupo'];
    gruNombre = json['gru_nombre'];
    lider = json['Lider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_grupo'] = idGrupo;
    data['gru_nombre'] = gruNombre;
    data['Lider'] = lider;
    return data;
  }
}
