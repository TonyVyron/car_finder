import 'dart:io';

import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/actuinfoperson.dart';
import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _image;
  String? UrlImage;
  bool islighted = true;
  final imagePicker = ImagePicker();

  actualizarfoto() async {
    if (_image != null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -90,
                    child: Container(
                        child: Image(
                      image: AssetImage("assets/carros.png"),
                      width: 120,
                      height: 120,
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60, bottom: 30),
                    alignment: Alignment.center,
                    child: Center(
                        child: Transform.scale(
                      scale: 1.8,
                      child: CircularProgressIndicator(
                        color: RED_CAR,
                      ),
                    )),
                  ),
                ],
              ),
              content: Text(
                'Espere, la foto está siendo Cambiada',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'biko', fontSize: 20),
              ),
            );
          });
      final storageRef = FirebaseStorage.instance.ref();
      final desertRef =
          storageRef.child("${loggedInUser.uid}/images").child('Foto_Perfil');

      await desertRef.delete();

      Reference ref = FirebaseStorage.instance
          .ref()
          .child("${loggedInUser.uid}/images")
          .child('Foto_Perfil');
      await ref.putFile(_image!);
      UrlImage = await ref.getDownloadURL();

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      await firebaseFirestore.collection('users').doc(loggedInUser.uid).update({
        "foto": UrlImage,
      });
      Navigator.pop(context);
    }
  }

  Future imagepickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
        actualizarfoto();
      } else {
        showsnackbar(
            'No hay imagen',
            Duration(milliseconds: 600),
            Icon(
              Icons.close,
              size: 25,
              color: Colors.white,
            ));
      }
    });
  }

  Future imagepickerCamara() async {
    final pick = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
        actualizarfoto();
      } else {
        showsnackbar(
            'No hay imagen',
            Duration(milliseconds: 600),
            Icon(
              Icons.close,
              size: 25,
              color: Colors.white,
            ));
      }
    });
  }

  showsnackbar(String texto, Duration d, Icon ic) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: d,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      content: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ic,
              Text(texto,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'biko',
                    fontSize: 20,
                    color: Colors.white,
                  ))
            ],
          )),
      backgroundColor: RED_CAR,
    ));
  }

  var consulta;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fofo2.png'), fit: BoxFit.fill)),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: loggedInUser.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Center(
                    child: Transform.scale(
                  scale: 1.6,
                  child: CircularProgressIndicator(
                    color: RED_CAR,
                  ),
                )),
              );
            } else {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?> perfil =
                        snapshot.data!.docs[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
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
                                        ? Icons.store_mall_directory
                                        : Icons.person,
                                    size: 30,
                                    color: RED_CAR,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 135,
                              width: 125,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: .5, color: Colors.black),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Colors.white),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 80,
                                        backgroundImage: perfil['foto'] == null
                                            ? Image.network(
                                                    'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg')
                                                .image
                                            : Image.network('${perfil['foto']}')
                                                .image,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      child: Center(
                                        heightFactor: 50,
                                        widthFactor: 50,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50),
                                                                topRight: Radius
                                                                    .circular(
                                                                        50))),
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    content:
                                                        SingleChildScrollView(
                                                            child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            imagepickerCamara();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 7,
                                                                    child: Text(
                                                                      "Tomar una foto",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'biko',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Icon(
                                                                      Icons
                                                                          .camera_alt_outlined,
                                                                      size: 35,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Divider(
                                                          thickness: 2,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            imagepickerMethod();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 7,
                                                                    child: Text(
                                                                      "Elegir una desde galería",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'biko',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Icon(
                                                                      Icons
                                                                          .photo_album_sharp,
                                                                      size: 35,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Divider(
                                                          thickness: 2,
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            onPrimary:
                                                                Colors.white,
                                                            primary: RED_CAR,
                                                            shadowColor:
                                                                Colors.white,
                                                            elevation: 15,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        10),
                                                            child: Text(
                                                              "Cancelar",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        )
                                                      ],
                                                    )),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .5),
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            width: 50,
                                            height: 50,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
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
                                        loggedInUser.status.toString() ==
                                                'Vendedor'
                                            ? Icons.directions_car
                                            : Icons.favorite,
                                        size: 30,
                                        color: RED_CAR,
                                      ),
                                      if (loggedInUser.status.toString() ==
                                          'Vendedor') ...[
                                        Container(
                                          child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('carros')
                                                  .where('uid_vendedor',
                                                      isEqualTo:
                                                          loggedInUser.uid)
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Container();
                                                } else {
                                                  return Text(
                                                    snapshot.data!.docs.length
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'biko',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  );
                                                }
                                              }),
                                        ),
                                      ],
                                      if (loggedInUser.status.toString() ==
                                          'Cliente') ...[
                                        Text(
                                            loggedInUser.Favoritos == null
                                                ? "0"
                                                : '${loggedInUser.Favoritos!.length - 1}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                color: Colors.black,
                                                fontSize: 16))
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                      loggedInUser.status.toString() ==
                                              'Vendedor'
                                          ? '${perfil['NombreLocal']}'
                                              .toTitleCase()
                                          : '${perfil['Nombre']} ${perfil['Apellidos']}'
                                              .toTitleCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'biko',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 25))),
                              if (loggedInUser.status.toString() ==
                                  'Vendedor') ...[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('estrellas')
                                          .doc(loggedInUser.uid)
                                          .collection('personas')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container(
                                            alignment: Alignment.center,
                                            child: Center(
                                                child: Transform.scale(
                                              scale: 1.3,
                                              child: CircularProgressIndicator(
                                                color: RED_CAR,
                                              ),
                                            )),
                                          );
                                        } else {
                                          double estre = 0;
                                          for (var i = 0;
                                              i < snapshot.data!.docs.length;
                                              i++) {
                                            QueryDocumentSnapshot<Object?>
                                                info_carro =
                                                snapshot.data!.docs[i];
                                            print(info_carro['estrellas']);

                                            estre += info_carro['estrellas'];
                                          }

                                          return RatingBarIndicator(
                                            rating:
                                                snapshot.data!.docs.length != 0
                                                    ? estre /
                                                        snapshot
                                                            .data!.docs.length
                                                    : 5.0,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemSize: 45.0,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            itemCount: 5,
                                          );
                                        }
                                      }),
                                ),
                              ],
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                loggedInUser.status
                                                            .toString() ==
                                                        'Vendedor'
                                                    ? "Teléfono de contacto:"
                                                        .toTitleCase()
                                                    : "Número de teléfono:"
                                                        .toTitleCase(),
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
                                                    : "${perfil['Telefono']}"
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
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  insetPadding:
                                                      EdgeInsets.all(10),
                                                  child: telefonoperson(
                                                    id: perfil['uid']
                                                        .toString(),
                                                    oto: perfil['foto']
                                                        .toString(),
                                                    telefono: perfil['Telefono']
                                                        .toString(),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.edit_sharp,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (loggedInUser.status.toString() ==
                                  'Vendedor') ...[
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Icon(
                                          Icons.store_mall_directory,
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
                                                  "Nombre del Local:"
                                                      .toTitleCase(),
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
                                                  "${perfil['NombreLocal']}"
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
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    insetPadding:
                                                        EdgeInsets.all(10),
                                                    child: actunamelocal(
                                                      id: perfil['uid']
                                                          .toString(),
                                                      oto: perfil['foto']
                                                          .toString(),
                                                      name:
                                                          perfil['NombreLocal']
                                                              .toString(),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 30,
                                          ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                loggedInUser.status
                                                            .toString() ==
                                                        'Vendedor'
                                                    ? "Nombre Del Encargado:"
                                                        .toTitleCase()
                                                    : "Nombre Completo:"
                                                        .toTitleCase(),
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
                                                "${perfil['Nombre']} ${perfil['Apellidos']}"
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
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  insetPadding:
                                                      EdgeInsets.all(10),
                                                  child: actunombre(
                                                    id: perfil['uid']
                                                        .toString(),
                                                    oto: perfil['foto']
                                                        .toString(),
                                                    nombre: perfil['Nombre']
                                                        .toString(),
                                                    apellido:
                                                        perfil['Apellidos']
                                                            .toString(),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 30,
                                        ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                loggedInUser.status
                                                            .toString() ==
                                                        'Vendedor'
                                                    ? "Edad del encargado:"
                                                        .toTitleCase()
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
                                                "${perfil['Edad']}"
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
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    insetPadding:
                                                        EdgeInsets.all(10),
                                                    child: actuedad(
                                                      edad: perfil['Edad']
                                                          .toString(),
                                                      oto: perfil['foto']
                                                          .toString(),
                                                      id: perfil['uid']
                                                          .toString(),
                                                    ));
                                              });
                                        },
                                        icon: Icon(
                                          Icons.edit_calendar,
                                          size: 30,
                                        ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                loggedInUser.status
                                                            .toString() ==
                                                        'Vendedor'
                                                    ? "Domicilio del Lugar:"
                                                        .toTitleCase()
                                                    : "Domicilio:"
                                                        .toTitleCase(),
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
                                                "${perfil['Direcc']}"
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
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    insetPadding:
                                                        EdgeInsets.all(10),
                                                    child: cambiarCor(
                                                      oto: perfil['foto']
                                                          .toString(),
                                                      id: perfil['uid']
                                                          .toString(),
                                                      name: perfil['Direcc']
                                                          .toString(),
                                                    ));
                                              });
                                        },
                                        icon: Icon(
                                          Icons.edit_location,
                                          size: 30,
                                        ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: Text(
                                                loggedInUser.status
                                                            .toString() ==
                                                        'Vendedor'
                                                    ? "Correo de Contacto:"
                                                        .toTitleCase()
                                                    : "Correo Electrónico:"
                                                        .toTitleCase(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: LABEL_INFO,
                                                  fontFamily: 'biko',
                                                  color: RED_CAR,
                                                )),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Text("${perfil['email']}",
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    color: Colors.black,
                                                    fontSize: LABEL_CAJA)),
                                          ),
                                        ],
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                      flex: 10,
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
                                                "${perfil['status']}"
                                                    .toTitleCase(),
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    color: Colors.black,
                                                    fontSize: LABEL_CAJA)),
                                          ),
                                        ],
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: Text(
                                                loggedInUser.status
                                                            .toString() ==
                                                        'Vendedor'
                                                    ? "ID del Local:"
                                                        .toTitleCase()
                                                    : "ID:".toTitleCase(),
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
                                                "${perfil['uid']}"
                                                    .toTitleCase(),
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    color: Colors.black,
                                                    fontSize: LABEL_CAJA)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }
          }),
    );
  }
}
