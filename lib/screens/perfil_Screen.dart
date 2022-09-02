import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var ax = "biko";

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  var consulta;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100,
                child: Container(
                  height: 300,
                  width: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: loggedInUser.foto == null
                            ? Image.network(
                                    'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg')
                                .image
                            : Image.network('${loggedInUser.foto}').image,
                        fit: BoxFit.fill),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                )),
            SizedBox(height: 10),
            Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: RED_CAR,
                child: Center(
                    child: Row(children: [
                  Container(
                    margin: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                      size: LABEL_SIZE * 1.5,
                    ),
                  ),
                  Text(
                    loggedInUser.status.toString() == 'Vendedor'
                        ? 'Datos de la tienda'.toTitleCase()
                        : 'Mis datos personales',
                    style: TextStyle(
                      fontFamily: 'biko',
                      fontSize: LABEL_SIZE,
                      color: Colors.white,
                    ),
                  )
                ]))),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TextParrafo(
                          text: loggedInUser.status.toString() == 'Vendedor'
                              ? " ID de tienda:".toTitleCase()
                              : " ID:".toTitleCase(),
                          icon: Icons.code,
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 18))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextValue(
                        text: "${loggedInUser.uid}".toTitleCase(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                  if (loggedInUser.status.toString() == 'Vendedor')
                    Divider(thickness: 2),
                  if (loggedInUser.status.toString() == 'Vendedor')
                    Align(
                        alignment: Alignment.centerLeft,
                        child: TextParrafo(
                            text: " Nombre de la tienda:".toTitleCase(),
                            icon: Icons.code,
                            style: TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 18))),
                  if (loggedInUser.status.toString() == 'Vendedor')
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextValue(
                          text: "${loggedInUser.NombreLocal}".toTitleCase(),
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 18)),
                    ),
                  Divider(thickness: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextParrafo(
                      text: loggedInUser.status.toString() == 'Vendedor'
                          ? "Encargado:".toTitleCase()
                          : "Nombre completo:".toTitleCase(),
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      icon: Icons.people,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextValue(
                        text: "${loggedInUser.Nombre} ${loggedInUser.Apellidos}"
                            .toTitleCase(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                  Divider(thickness: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextParrafo(
                      text: loggedInUser.status.toString() == 'Vendedor'
                          ? " Edad del encargado:".toTitleCase()
                          : " Edad:".toTitleCase(),
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      icon: Icons.numbers,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextValue(
                        text: "${loggedInUser.Edad}".toTitleCase(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                  Divider(thickness: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextParrafo(
                      text: loggedInUser.status.toString() == 'Vendedor'
                          ? " Teléfono de Contacto:".toTitleCase()
                          : " Número de Teléfono:".toTitleCase(),
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      icon: Icons.phone,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextValue(
                        text: loggedInUser.Telefono == null
                            ? " Sin Número"
                            : "${loggedInUser.Telefono}".toTitleCase(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                  Divider(thickness: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextParrafo(
                        text: loggedInUser.status.toString() == 'Vendedor'
                            ? " Correo de contacto:".toTitleCase()
                            : " Correo electrónico:".toTitleCase(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18),
                        icon: Icons.email),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextValue(
                        text: "${loggedInUser.email}",
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                  Divider(thickness: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextParrafo(
                      text: "Estatus:".toTitleCase(),
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      icon: Icons.verified_user,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextValue(
                        text: "${loggedInUser.status}".toTitleCase(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                  Divider(thickness: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextParrafo(
                      text: loggedInUser.status.toString() == 'Vendedor'
                          ? " Domicilio de la tienda:".toTitleCase()
                          : " Domicilio:".toTitleCase(),
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      icon: Icons.place,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextValue(
                        text: "${loggedInUser.Direcc}".toTitleCase(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
