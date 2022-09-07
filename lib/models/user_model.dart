class UserModel {
  String? uid;
  String? foto;
  String? email;
  String? Nombre;
  String? NombreLocal;
  String? Apellidos;
  List? Favoritos;
  String? Telefono;
  String? Edad;
  String? status;
  String? Direcc;
  double? Cor_lat;
  double? Cor_long;

  UserModel(
      {this.uid,
      this.email,
      this.foto,
      this.Nombre,
      this.Favoritos,
      this.NombreLocal,
      this.Telefono,
      this.Apellidos,
      this.Edad,
      this.Cor_lat,
      this.Cor_long,
      this.status,
      this.Direcc});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        foto: map['foto'],
        Favoritos: map['Favoritos'],
        NombreLocal: map['NombreLocal'],
        Telefono: map['Telefono'],
        Nombre: map['Nombre'],
        Apellidos: map['Apellidos'],
        Cor_lat: map['Cor_lat'],
        Cor_long: map['Cor_long'],
        Edad: map['Edad'],
        status: map['status'],
        Direcc: map['Direcc']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'Nombre': Nombre,
      'Apellidos': Apellidos,
      'Edad': Edad,
      'Favoritos': Favoritos,
      'Telefono': Telefono,
      'status': status,
      'Cor_long': Cor_long,
      'Cor_lat': Cor_lat,
      'NombreLocal': NombreLocal,
      'foto': foto,
      'Direcc': Direcc,
    };
  }
}
