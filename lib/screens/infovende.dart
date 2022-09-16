import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/carrosgeneral.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class infovende extends StatefulWidget {
  String id_vendedor;
  String id_per;
  infovende({Key? key, required this.id_vendedor, required this.id_per})
      : super(key: key);

  @override
  State<infovende> createState() => _infovendeState();
}

class _infovendeState extends State<infovende> {
  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser2 = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.id_vendedor)
        .get()
        .then((value) {
      this.loggedInUser2 = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  late double _rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage('assets/fofo2.png'), fit: BoxFit.fill)),
      height: 600,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 30,
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.white,
                  ),
                )),
            CircleAvatar(
              radius: 68,
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.network(loggedInUser2.foto.toString()).image,
                      fit: BoxFit.cover),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                loggedInUser2.Telefono == null
                    ? "Sin Nombre"
                    : loggedInUser2.NombreLocal.toString(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontFamily: 'biko', fontSize: 22, color: RED_CAR),
              ),
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
                      size: 25,
                      color: RED_CAR,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text("nOMBRE DEL eNCARGADO:".toTitleCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'biko',
                                color: RED_CAR,
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                              loggedInUser2.Nombre == null
                                  ? "Sin Nombre"
                                  : '${loggedInUser2.Nombre} ${loggedInUser2.Apellidos}'
                                      .toString(),
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 14)),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.phone,
                      size: 25,
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
                              loggedInUser2.status.toString() == 'Vendedor'
                                  ? "Teléfono de contacto:".toTitleCase()
                                  : "Número de teléfono:".toTitleCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'biko',
                                color: RED_CAR,
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                              loggedInUser2.Telefono == null
                                  ? "Sin Número"
                                  : "${loggedInUser2.Telefono}".toTitleCase(),
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 14)),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.place,
                      size: 25,
                      color: RED_CAR,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text("Domicilio del Lugar:".toTitleCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'biko',
                                color: RED_CAR,
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                              loggedInUser2.Direcc == null
                                  ? "Sin Dirección"
                                  : "${loggedInUser2.Direcc}".toTitleCase(),
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 14)),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.email,
                      size: 25,
                      color: RED_CAR,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text("Correo del Encargado:".toTitleCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'biko',
                                color: RED_CAR,
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                              loggedInUser2.Telefono == null
                                  ? "Sin Email"
                                  : loggedInUser2.email.toString(),
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 14)),
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
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Puntuar Vendedor:'.toString(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontFamily: 'biko', fontSize: 22, color: RED_CAR),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('estrellas')
                      .doc(widget.id_vendedor)
                      .collection('personas')
                      .where('uid_persona', isEqualTo: widget.id_per)
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
                      if (snapshot.data!.docs.length == 0) {
                        return RatingBar.builder(
                          minRating: 1,
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(50))),
                                      backgroundColor: Colors.white,
                                      title: Text("Puntuar al Vendedor",
                                          style: TextStyle(
                                            fontFamily: 'biko',
                                            color: Colors.black,
                                            fontSize: 25,
                                          )),
                                      content: Text(
                                          "¿Desea Puntuar al vendedor con ${_rating} estrellas?",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: 'biko',
                                          )),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              color: RED_CAR,
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            postestrellas();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                right: 13,
                                                top: 10,
                                                bottom: 10,
                                                left: 13),
                                            color: RED_CAR,
                                            child: Text(
                                              "Sí",
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                          },
                        );
                      } else {
                        return Container(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('estrellas')
                                  .doc(widget.id_vendedor)
                                  .collection('personas')
                                  .where('uid_persona',
                                      isEqualTo: widget.id_per)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
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
                                  QueryDocumentSnapshot<Object?> rate =
                                      snapshot.data!.docs[0];
                                  return RatingBar.builder(
                                    minRating: 1,
                                    initialRating: rate['estrellas'],
                                    itemBuilder: (context, _) =>
                                        Icon(Icons.star, color: Colors.amber),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        _rating = rating;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (_) => new AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    50))),
                                                backgroundColor: Colors.white,
                                                title:
                                                    Text("Cambiar Puntuación",
                                                        style: TextStyle(
                                                          fontFamily: 'biko',
                                                          color: Colors.black,
                                                          fontSize: 25,
                                                        )),
                                                content: Text(
                                                    "¿Desea Cambiar la Puntuación con ${_rating} estrellas?",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontFamily: 'biko',
                                                    )),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        color: RED_CAR,
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      actuestrellas();
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          right: 13,
                                                          top: 10,
                                                          bottom: 10,
                                                          left: 13),
                                                      color: RED_CAR,
                                                      child: Text(
                                                        "Sí",
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ));
                                    },
                                  );
                                }
                              }),
                        );
                      }
                    }
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.store_mall_directory,
                      size: 30,
                      color: RED_CAR,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Más de esta tienda'.toTitleCase(),
                      style: TextStyle(
                        fontFamily: 'biko',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.5,
                        color: RED_CAR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            carrogeneral(id_vendedor: widget.id_vendedor),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  postestrellas() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection('estrellas')
        .doc(widget.id_vendedor)
        .collection('personas')
        .doc(widget.id_per)
        .set({
      'estrellas': _rating,
      'uid_persona': widget.id_per,
      'uid_vendedor': widget.id_vendedor
    });
  }

  actuestrellas() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection('estrellas')
        .doc(widget.id_vendedor)
        .collection('personas')
        .doc(widget.id_per)
        .update({
      'estrellas': _rating,
    });
  }
}
