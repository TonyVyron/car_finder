import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/carrosgeneral.dart';
import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/screens/mapa.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(181, 250, 39, 39),
                    RED_CAR,
                  ],
                ),
              ),
              height: 140,
              width: double.infinity,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -140,
                child: SizedBox(
                  height: 125,
                  width: 125,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .5, color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundImage: loggedInUser.foto == null
                                ? Image.network(
                                        'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg')
                                    .image
                                : Image.network('${loggedInUser.foto}').image,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                            height: 46,
                            width: 46,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                  )),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -90,
                left: 15,
                child: Container(
                  width: 80,
                  height: 90,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(width: .4),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(103, 0, 0, 0),
                          offset: Offset(0, 5),
                          blurRadius: 10.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    loggedInUser.status.toString() == 'Vendedor'
                        ? Icons.shopping_cart
                        : Icons.person,
                    size: 30,
                    color: RED_CAR,
                  ),
                ),
              ),
              Positioned(
                top: -90,
                right: 15,
                child: Container(
                  width: 80,
                  height: 90,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(width: .4),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(103, 0, 0, 0),
                          offset: Offset(0, 5),
                          blurRadius: 10.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Icon(
                        loggedInUser.status.toString() == 'Vendedor'
                            ? Icons.directions_car
                            : Icons.favorite,
                        size: 30,
                        color: RED_CAR,
                      ),
                      Text("30",
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: double.infinity,
                      child: Text(
                          loggedInUser.status.toString() == 'Vendedor'
                              ? '${loggedInUser.NombreLocal}'.toTitleCase()
                              : '${loggedInUser.Nombre} ${loggedInUser.Apellidos}'
                                  .toTitleCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 25))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: .4),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(103, 0, 0, 0),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.code,
                            size: 26,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                    loggedInUser.status.toString() == 'Vendedor'
                                        ? "IDENTIFICADOR del Local:"
                                            .toTitleCase()
                                        : "IDENTIFICADOR:".toTitleCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: LABEL_INFO,
                                      fontFamily: 'biko',
                                      color: RED_CAR,
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text("${loggedInUser.uid}".toTitleCase(),
                                    style: TextStyle(
                                        fontFamily: 'biko',
                                        color: Colors.black,
                                        fontSize: LABEL_CAJA)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (loggedInUser.status.toString() == 'Vendedor')
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: .4),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(103, 0, 0, 0),
                              offset: Offset(0, 5),
                              blurRadius: 10.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.code,
                              size: 26,
                              color: RED_CAR,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text("Nombre del Local:".toTitleCase(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: LABEL_INFO,
                                        fontFamily: 'biko',
                                        color: RED_CAR,
                                      )),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                      "${loggedInUser.NombreLocal}"
                                          .toTitleCase(),
                                      style: TextStyle(
                                          fontFamily: 'biko',
                                          color: Colors.black,
                                          fontSize: LABEL_CAJA)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if (loggedInUser.status.toString() == 'Vendedor') ...[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: .4),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(103, 0, 0, 0),
                              offset: Offset(0, 5),
                              blurRadius: 10.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.people,
                              size: 26,
                              color: RED_CAR,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                      loggedInUser.status.toString() ==
                                              'Vendedor'
                                          ? "NOMBRE Del Encargado:"
                                              .toTitleCase()
                                          : "NOMBRE COMPLETO:".toTitleCase(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: LABEL_INFO,
                                        fontFamily: 'biko',
                                        color: RED_CAR,
                                      )),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                      "${loggedInUser.Nombre} ${loggedInUser.Apellidos}"
                                          .toTitleCase(),
                                      style: TextStyle(
                                          fontFamily: 'biko',
                                          color: Colors.black,
                                          fontSize: LABEL_CAJA)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: .4),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(103, 0, 0, 0),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.date_range,
                            size: 26,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                    loggedInUser.status.toString() == 'Vendedor'
                                        ? "Edad Del Encargado:".toTitleCase()
                                        : "Edad:".toTitleCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: LABEL_INFO,
                                        fontFamily: 'biko',
                                        color: RED_CAR)),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                    "${loggedInUser.Edad}".toTitleCase(),
                                    style: TextStyle(
                                        fontFamily: 'biko',
                                        color: Colors.black,
                                        fontSize: LABEL_CAJA)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: .4),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(103, 0, 0, 0),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.phone,
                            size: 26,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                    loggedInUser.status.toString() == 'Vendedor'
                                        ? "Teléfono de Contacto:".toTitleCase()
                                        : "Número de Teléfono:".toTitleCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: LABEL_INFO,
                                      fontFamily: 'biko',
                                      color: RED_CAR,
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                    loggedInUser.Telefono == null
                                        ? "Sin Número"
                                        : "${loggedInUser.Telefono}"
                                            .toTitleCase(),
                                    style: TextStyle(
                                        fontFamily: 'biko',
                                        color: Colors.black,
                                        fontSize: LABEL_CAJA)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: .4),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(103, 0, 0, 0),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.email,
                            size: 26,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                    loggedInUser.status.toString() == 'Vendedor'
                                        ? "Correo de Contacto:".toTitleCase()
                                        : "Correo Electrónico:".toTitleCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: LABEL_INFO,
                                      fontFamily: 'biko',
                                      color: RED_CAR,
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text("${loggedInUser.email}",
                                    style: TextStyle(
                                        fontFamily: 'biko',
                                        color: Colors.black,
                                        fontSize: LABEL_CAJA)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: .4),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(103, 0, 0, 0),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.person,
                            size: 26,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text("Status:".toTitleCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: LABEL_INFO,
                                      fontFamily: 'biko',
                                      color: RED_CAR,
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                    "${loggedInUser.status}".toTitleCase(),
                                    style: TextStyle(
                                        fontFamily: 'biko',
                                        color: Colors.black,
                                        fontSize: LABEL_CAJA)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: .4),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(103, 0, 0, 0),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.place,
                            size: 26,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                    loggedInUser.status.toString() == 'Vendedor'
                                        ? "Domicilio del Lugar:".toTitleCase()
                                        : "Domicilio:".toTitleCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: LABEL_INFO,
                                      fontFamily: 'biko',
                                      color: RED_CAR,
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                    "${loggedInUser.Direcc}".toTitleCase(),
                                    style: TextStyle(
                                        fontFamily: 'biko',
                                        color: Colors.black,
                                        fontSize: LABEL_CAJA)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
