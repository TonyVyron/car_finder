import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/readData/get_user_name.dart';
import 'package:car_finder/screens/logintipo.dart';
import 'package:car_finder/widgets/widgets.dart';
//import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
                        ? 'Datos de mi Local'.toTitleCase()
                        : 'Mis Datos Personales',
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
                              ? " IDENTIFICADOR del Local:".toTitleCase()
                              : " IDENTIFICADOR:".toTitleCase(),
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
                            text: " Nombre del Local:".toTitleCase(),
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
                          ? " NOMBRE Del Encargado:".toTitleCase()
                          : " NOMBRE COMPLETO:".toTitleCase(),
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
                          ? " Edad Del Encargado:".toTitleCase()
                          : " Edad:".toTitleCase(),
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      icon: Icons.view_agenda,
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
                      icon: Icons.view_agenda,
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
                            ? " Correo de Contacto:".toTitleCase()
                            : " Correo Electrónico:".toTitleCase(),
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
                      text: " Status:".toTitleCase(),
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      icon: Icons.person_add,
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
                          ? " Domicilio del Lugar:".toTitleCase()
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
            // Text(
            //   'Nombre: ${loggedInUser.Nombre}${loggedInUser.Apellidos}  ' +
            //       '\nApellidos: ${loggedInUser.Apellidos}' +
            //       ' \nEdad: ${loggedInUser.Edad}' +
            //       ' \nEmail: ${loggedInUser.email}' +
            //       ' \nStatus: ${loggedInUser.status}' +
            //       ' \nID: ${loggedInUser.uid}' +
            //       ' \nDomicilio: ${loggedInUser.Direcc}',
            //   style: TextStyle(
            //     fontFamily: 'biko',
            //     color: Colors.black,
            //     fontWeight: FontWeight.w500,
            //     fontSize: 15.5,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
