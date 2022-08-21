import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? foto;
  String? email;
  String? Nombre;
  String? NombreLocal;
  String? Apellidos;
  String? Telefono;
  String? Edad;
  String? status;
  String? Direcc;

  UserModel(
      {this.uid,
      this.email,
      this.foto,
      this.Nombre,
      this.NombreLocal,
      this.Telefono,
      this.Apellidos,
      this.Edad,
      this.status,
      this.Direcc});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        foto: map['foto'],
        NombreLocal: map['NombreLocal'],
        Telefono: map['Telefono'],
        Nombre: map['Nombre'],
        Apellidos: map['Apellidos'],
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
      'Telefono': Telefono,
      'status': status,
      'NombreLocal': NombreLocal,
      'foto': foto,
      'Direcc': Direcc,
    };
  }
}
