import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/infoAutos.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_indicator/page_indicator.dart';

class mis_carros extends StatefulWidget {
  mis_carros({Key? key}) : super(key: key);

  @override
  State<mis_carros> createState() => _mis_carrosState();
}

class _mis_carrosState extends State<mis_carros> {
  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser = UserModel();

  bool _estrella = false;
  bool _estrella2 = false;
  bool _estrella3 = false;

  final maxheight = 0.9;
  final minheight = 0.4;
  final initheight = 0.4;

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

  Future firedelete(String id_vendedor, String id_carro, int largo) async {
    for (var i = 0; i < largo; i++) {
      final storageRef = FirebaseStorage.instance.ref();
      final desertRef = storageRef
          .child("${user.uid}/images")
          .child('Vehículo_${id_carro}')
          .child('Subido_${i + 1}');

      await desertRef.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('carros')
          .where('uid_vendedor', isEqualTo: loggedInUser.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'No Tienes Vehículos Registrados',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'biko', fontSize: 22, color: Colors.black),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot<Object?> info_carro =
                    snapshot.data!.docs[index];

                double promo = 0.0;
                double descuento = 0.0;
                double promo2 = 0.0;
                double descuento2 = 0.0;

                String numberFormat(double x) {
                  List<String> parts = x.toString().split('.');
                  RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

                  parts[0] = parts[0].replaceAll(re, ',');
                  if (parts.length == 1) {
                    parts.add('0');
                  } else {
                    parts[1] = parts[1].padRight(2, '0').substring(0, 0);
                  }
                  return parts.join('');
                }

                String numberFormat2(int x) {
                  List<String> parts = x.toString().split('.');
                  RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

                  parts[0] = parts[0].replaceAll(re, ',');
                  if (parts.length == 1) {
                    parts.add('');
                  } else {
                    parts[1] = parts[1].padRight(2, '0').substring(0, 0);
                  }
                  return parts.join('');
                }

                if (info_carro['porcentaje_descuento'] != null) {
                  descuento = (info_carro['precio'] / 100) *
                      info_carro['porcentaje_descuento'];
                  promo = info_carro['precio'] - descuento;
                } else {
                  if (info_carro['porcentaje_falla'] != null) {
                    descuento2 = (info_carro['precio'] / 100) *
                        info_carro['porcentaje_falla'];
                    promo2 = info_carro['precio'] - descuento2;
                  }
                }

                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: info_carro['tipo_agregado'] == 1
                        ? InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                )),
                                builder: (context) => DraggableScrollableSheet(
                                    initialChildSize: 0.4,
                                    maxChildSize: 0.9,
                                    minChildSize: 0.32,
                                    expand: false,
                                    builder: (context, scrollController) {
                                      return SingleChildScrollView(
                                          controller: scrollController,
                                          child: AutosInfo(
                                              imagen: info_carro['fotos'],
                                              context: context,
                                              yo: loggedInUser.status
                                                  .toString(),
                                              precio: numberFormat2(
                                                  info_carro['precio']),
                                              Marca: info_carro['nombre_marca'],
                                              puertas:
                                                  info_carro['numero_puertas'],
                                              Nombre:
                                                  info_carro['nombre_carro'],
                                              garantia: info_carro['garantia'],
                                              Kilometraje:
                                                  '${info_carro['kilometraje']} km',
                                              modelo: info_carro['ano_modelo'],
                                              Gasolina:
                                                  info_carro['tipo_gasolina'],
                                              tipouso: info_carro['tipo_uso'],
                                              Fecha: info_carro['fecha_compra'],
                                              potencia: '6.21/100 km',
                                              Guia: info_carro[
                                                  'guia_mantenimiento'],
                                              id_vendedor:
                                                  info_carro['uid_vendedor'],
                                              porcentaje: info_carro[
                                                      'porcentaje_descuento']
                                                  .toString(),
                                              promocion: numberFormat(promo),
                                              traccion: info_carro['traccion'],
                                              carroceria:
                                                  info_carro['carroceria'],
                                              tipoCaja:
                                                  info_carro['tipo_agregado']));
                                    }),
                              );
                            },
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(.4),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(197, 0, 0, 0),
                                        offset: Offset(4, 4),
                                        blurRadius: 6.0,
                                      ),
                                    ]),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Image.network(
                                                info_carro['fotos'][0]
                                                    .toString(),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        child: TextParrafo(
                                                          text:
                                                              '${info_carro['nombre_carro']}'
                                                                  .toString()
                                                                  .toTitleCase(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 25,
                                                              color: RED_CAR),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        child: TextParrafo(
                                                          text: info_carro[
                                                                  'nombre_marca']
                                                              .toString()
                                                              .toTitleCase(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        child: TextParrafo(
                                                          text:
                                                              '\$ ${numberFormat(promo)}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            child: TextParrafo(
                                                              text:
                                                                  '\$ ${numberFormat2(info_carro['precio'])}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  fontSize: 18,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    child: TextParrafo(
                                                        text:
                                                            '${info_carro['kilometraje'].toString()} km',
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
                                                            color:
                                                                Colors.black),
                                                        icon: Icons
                                                            .av_timer_sharp),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    child: TextParrafo(
                                                        text:
                                                            '${info_carro['fecha_compra'].toString()}',
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
                                                            color:
                                                                Colors.black),
                                                        icon: Icons.date_range),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      child: Row(children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 3),
                                                      child: Icon(
                                                        Icons.local_gas_station,
                                                        color: RED_CAR,
                                                        size: LABEL_SIZE * 1.5,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        info_carro[
                                                            'tipo_gasolina'],
                                                        style: TextStyle(
                                                          fontFamily: 'biko',
                                                          fontSize: LABEL_CAJA,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                  ])),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      child: Row(children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 3),
                                                      child: Icon(
                                                        Icons.family_restroom,
                                                        color: RED_CAR,
                                                        size: LABEL_SIZE * 1.5,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        info_carro['tipo_uso'],
                                                        style: TextStyle(
                                                          fontFamily: 'biko',
                                                          fontSize: LABEL_CAJA,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                  ])),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    child: TextParrafo(
                                                        text: '4,21/100 km',
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
                                                            color:
                                                                Colors.black),
                                                        icon: Icons.bolt),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    child: TextParrafo(
                                                        text: info_carro[
                                                                'carroceria']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
                                                            color:
                                                                Colors.black),
                                                        icon: Icons
                                                            .directions_car),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 8,
                                                  child: Container(
                                                    child: TextParrafo(
                                                      text:
                                                          '${info_carro['nombre_carro']} ${info_carro['nombre_marca']}...'
                                                              .toTitleCase(),
                                                      style: TextStyle(
                                                          fontFamily: 'biko',
                                                          fontSize: 20,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all()),
                                                      child: IconButton(
                                                        icon: Icon(Icons.delete,
                                                            size: 35,
                                                            color: RED_CAR),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  new AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.only(topRight: Radius.circular(50))),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    title: Text(
                                                                        "Eliminar Vehículo",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'biko',
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              25,
                                                                        )),
                                                                    content: Text(
                                                                        "¿Desea Eliminar este Vehículo?",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              'biko',
                                                                        )),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(10),
                                                                            color:
                                                                                RED_CAR,
                                                                            child:
                                                                                Text(
                                                                              "No",
                                                                              style: TextStyle(fontFamily: 'biko', color: Colors.white, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          )),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          final id_car =
                                                                              info_carro['uid'];
                                                                          final cant_fotos =
                                                                              info_carro['fotos'].length;

                                                                          setState(
                                                                              () {
                                                                            FirebaseFirestore.instance.collection("users").doc(loggedInUser.uid).collection('Vehículos').doc(id_car).delete().then(
                                                                                  (doc) => print("Document deleted"),
                                                                                  onError: (e) => print("Error updating document $e"),
                                                                                );

                                                                            FirebaseFirestore.instance.collection("carros").doc(id_car).delete().then(
                                                                                  (doc) => print("Document deleted"),
                                                                                  onError: (e) => print("Error updating document $e"),
                                                                                );

                                                                            print('/${loggedInUser.uid}/images/Vehículo_${id_car}');

                                                                            firedelete(
                                                                                loggedInUser.uid.toString(),
                                                                                id_car,
                                                                                cant_fotos);

                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                                                              content: Container(
                                                                                  width: double.infinity,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.delete,
                                                                                        size: 25,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      Text('Vehículo Eliminado',
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
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.only(
                                                                              right: 13,
                                                                              top: 10,
                                                                              bottom: 10,
                                                                              left: 13),
                                                                          color:
                                                                              RED_CAR,
                                                                          child:
                                                                              Text(
                                                                            "Si",
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
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: -15,
                                      child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 21, 110, 183),
                                          ),
                                          child: Text(
                                            "Promoción",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 15,
                                                color: Colors.white),
                                          )),
                                    ),
                                    Positioned(
                                      right: -15,
                                      top: 10,
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.green),
                                          child: Text(
                                            "${info_carro['porcentaje_descuento']} %",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                    )
                                  ],
                                )))
                        : info_carro['tipo_agregado'] == 2
                            ? InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    )),
                                    builder: (context) =>
                                        DraggableScrollableSheet(
                                            initialChildSize: 0.4,
                                            maxChildSize: 0.9,
                                            minChildSize: 0.32,
                                            expand: false,
                                            builder:
                                                (context, scrollController) {
                                              return SingleChildScrollView(
                                                  controller: scrollController,
                                                  child: AutosInfo(
                                                      imagen:
                                                          info_carro['fotos'],
                                                      context: context,
                                                      precio: numberFormat2(
                                                          info_carro['precio']),
                                                      yo: loggedInUser.status
                                                          .toString(),
                                                      Marca: info_carro[
                                                          'nombre_marca'],
                                                      Nombre: info_carro[
                                                          'nombre_carro'],
                                                      id_vendedor: info_carro[
                                                          'uid_vendedor'],
                                                      garantia: info_carro[
                                                          'garantia'],
                                                      puertas: info_carro[
                                                          'numero_puertas'],
                                                      Kilometraje:
                                                          '${info_carro['kilometraje']} km',
                                                      Gasolina: info_carro[
                                                          'tipo_gasolina'],
                                                      tipouso: info_carro[
                                                          'tipo_uso'],
                                                      modelo: info_carro[
                                                          'ano_modelo'],
                                                      Fecha: info_carro[
                                                          'fecha_compra'],
                                                      potencia: '6.21/100 km',
                                                      Guia: info_carro[
                                                          'guia_mantenimiento'],
                                                      traccion: info_carro[
                                                          'traccion'],
                                                      carroceria: info_carro[
                                                          'carroceria'],
                                                      tipoCaja: info_carro[
                                                          'tipo_agregado']));
                                            }),
                                  );
                                },
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(.4),
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(197, 0, 0, 0),
                                            offset: Offset(-4, 4),
                                            blurRadius: 6.0,
                                          ),
                                        ]),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Image.network(
                                                    info_carro['fotos'][0]
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            child: TextParrafo(
                                                              text: '${info_carro['nombre_carro']}'
                                                                  .toString()
                                                                  .toTitleCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 25,
                                                                  color:
                                                                      RED_CAR),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            child: TextParrafo(
                                                              text: info_carro[
                                                                      'nombre_marca']
                                                                  .toString()
                                                                  .toTitleCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                child:
                                                                    TextParrafo(
                                                                  text:
                                                                      '\$ ${numberFormat2(info_carro['precio'])}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'biko',
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text:
                                                                '${info_carro['kilometraje']} km',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons
                                                                .av_timer_sharp),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text:
                                                                '${info_carro['fecha_compra']}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons
                                                                .date_range),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          child: Row(children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 3),
                                                          child: Icon(
                                                            Icons
                                                                .local_gas_station,
                                                            color: RED_CAR,
                                                            size: LABEL_SIZE *
                                                                1.5,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            info_carro[
                                                                'tipo_gasolina'],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize:
                                                                  LABEL_CAJA,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        )
                                                      ])),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          child: Row(children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 3),
                                                          child: Icon(
                                                            Icons
                                                                .family_restroom,
                                                            color: RED_CAR,
                                                            size: LABEL_SIZE *
                                                                1.5,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            info_carro[
                                                                'tipo_uso'],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize:
                                                                  LABEL_CAJA,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        )
                                                      ])),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text: info_carro[
                                                                'ano_modelo'],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons
                                                                .calendar_today_rounded),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text:
                                                                '${info_carro['carroceria']}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons
                                                                .directions_car),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.black,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 8,
                                                      child: Container(
                                                        child: TextParrafo(
                                                          text:
                                                              '${info_carro['nombre_carro']} ${info_carro['nombre_marca']}...'
                                                                  .toTitleCase(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border:
                                                                  Border.all()),
                                                          child: IconButton(
                                                            icon: Icon(
                                                                Icons.delete,
                                                                size: 35,
                                                                color: RED_CAR),
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      new AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(topRight: Radius.circular(50))),
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        title: Text(
                                                                            "Eliminar Vehículo",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'biko',
                                                                              color: Colors.black,
                                                                              fontSize: 25,
                                                                            )),
                                                                        content: Text(
                                                                            "¿Desea Eliminar este Vehículo?",
                                                                            style:
                                                                                TextStyle(
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
                                                                                  style: TextStyle(fontFamily: 'biko', color: Colors.white, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              )),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              final id_car = info_carro['uid'];
                                                                              final cant_fotos = info_carro['fotos'].length;

                                                                              setState(() {
                                                                                FirebaseFirestore.instance.collection("users").doc(loggedInUser.uid).collection('Vehículos').doc(id_car).delete().then(
                                                                                      (doc) => print("Document deleted"),
                                                                                      onError: (e) => print("Error updating document $e"),
                                                                                    );

                                                                                FirebaseFirestore.instance.collection("carros").doc(id_car).delete().then(
                                                                                      (doc) => print("Document deleted"),
                                                                                      onError: (e) => print("Error updating document $e"),
                                                                                    );

                                                                                print('/${loggedInUser.uid}/images/Vehículo_${id_car}');

                                                                                firedelete(loggedInUser.uid.toString(), id_car, cant_fotos);

                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                                                                  content: Container(
                                                                                      width: double.infinity,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.delete,
                                                                                            size: 25,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                          Text('Vehículo Eliminado',
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
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.only(right: 13, top: 10, bottom: 10, left: 13),
                                                                              color: RED_CAR,
                                                                              child: Text(
                                                                                "Si",
                                                                                style: TextStyle(fontFamily: 'biko', color: Colors.white, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ));
                                                            },
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: -15,
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                              ),
                                              child: Text(
                                                "Recomendación",
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ],
                                    )))
                            : InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    )),
                                    builder: (context) =>
                                        DraggableScrollableSheet(
                                            initialChildSize: 0.4,
                                            maxChildSize: 0.9,
                                            minChildSize: 0.32,
                                            expand: false,
                                            builder:
                                                (context, scrollController) {
                                              return SingleChildScrollView(
                                                  controller: scrollController,
                                                  child: AutosInfo(
                                                      imagen:
                                                          info_carro['fotos'],
                                                      context: context,
                                                      yo: loggedInUser.status
                                                          .toString(),
                                                      precio: numberFormat2(
                                                          info_carro['precio']),
                                                      Marca: info_carro[
                                                          'nombre_marca'],
                                                      id_vendedor: info_carro[
                                                          'uid_vendedor'],
                                                      Nombre: info_carro[
                                                          'nombre_carro'],
                                                      Kilometraje:
                                                          '${info_carro['kilometraje']} km',
                                                      Gasolina: info_carro[
                                                          'tipo_gasolina'],
                                                      promocion:
                                                          numberFormat(promo2),
                                                      puertas: info_carro[
                                                          'numero_puertas'],
                                                      porcentaje: info_carro[
                                                              'porcentaje_falla']
                                                          .toString(),
                                                      tipouso: info_carro[
                                                          'tipo_uso'],
                                                      detalleprin: info_carro[
                                                          'detalle_principal'],
                                                      modelo: info_carro[
                                                          'ano_modelo'],
                                                      garantia: info_carro[
                                                          'garantia'],
                                                      detalles: info_carro[
                                                          'detalles'],
                                                      Guia:
                                                          info_carro['guia_mantenimiento'],
                                                      Fecha: info_carro['fecha_compra'],
                                                      potencia: '6.21/100 km',
                                                      traccion: info_carro['traccion'],
                                                      carroceria: info_carro['carroceria'],
                                                      tipoCaja: info_carro['tipo_agregado']));
                                            }),
                                  );
                                },
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(.4),
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(197, 0, 0, 0),
                                            offset: Offset(-4, 4),
                                            blurRadius: 6.0,
                                          ),
                                        ]),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Image.network(
                                                    info_carro['fotos'][0]
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            child: TextParrafo(
                                                              text: '${info_carro['nombre_carro']}'
                                                                  .toString()
                                                                  .toTitleCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 25,
                                                                  color:
                                                                      RED_CAR),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            child: TextParrafo(
                                                              text: info_carro[
                                                                      'nombre_marca']
                                                                  .toString()
                                                                  .toTitleCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 4,
                                                              child: Container(
                                                                child:
                                                                    TextParrafo(
                                                                  text:
                                                                      '\$ ${numberFormat(promo2)}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'biko',
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                child:
                                                                    TextParrafo(
                                                                  text:
                                                                      '${info_carro['porcentaje_falla']}%',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'biko',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          RED_CAR),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            child: TextParrafo(
                                                              text:
                                                                  '\$ ${numberFormat2(info_carro['precio'])}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  fontSize: 18,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      RED_CAR),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            child: TextParrafo(
                                                              text: info_carro[
                                                                      'detalle_principal']
                                                                  .toString()
                                                                  .toTitleCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  fontSize: 16,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color:
                                                                      RED_CAR),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text:
                                                                '${info_carro['kilometraje']} km',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons
                                                                .av_timer_sharp),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text:
                                                                '${info_carro['fecha_compra']}',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons
                                                                .date_range),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          child: Row(children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 3),
                                                          child: Icon(
                                                            Icons
                                                                .local_gas_station,
                                                            color: RED_CAR,
                                                            size: LABEL_SIZE *
                                                                1.5,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            info_carro[
                                                                'tipo_gasolina'],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize:
                                                                  LABEL_CAJA,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        )
                                                      ])),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          child: Row(children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 3),
                                                          child: Icon(
                                                            Icons
                                                                .family_restroom,
                                                            color: RED_CAR,
                                                            size: LABEL_SIZE *
                                                                1.5,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            info_carro[
                                                                'tipo_uso'],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize:
                                                                  LABEL_CAJA,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        )
                                                      ])),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text: '7,21/100 km',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons.bolt),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: TextParrafo(
                                                            text: info_carro[
                                                                    'carroceria']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black),
                                                            icon: Icons
                                                                .directions_car),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.black,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 8,
                                                      child: Container(
                                                        child: TextParrafo(
                                                          text:
                                                              '${info_carro['nombre_carro']} ${info_carro['nombre_marca']}...'
                                                                  .toTitleCase(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'biko',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border:
                                                                  Border.all()),
                                                          child: IconButton(
                                                            icon: Icon(
                                                                Icons.delete,
                                                                size: 35,
                                                                color: RED_CAR),
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      new AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(topRight: Radius.circular(50))),
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        title: Text(
                                                                            "Eliminar Vehículo",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'biko',
                                                                              color: Colors.black,
                                                                              fontSize: 25,
                                                                            )),
                                                                        content: Text(
                                                                            "¿Desea Eliminar este Vehículo?",
                                                                            style:
                                                                                TextStyle(
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
                                                                                  style: TextStyle(fontFamily: 'biko', color: Colors.white, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              )),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              final id_car = info_carro['uid'];
                                                                              final cant_fotos = info_carro['fotos'].length;

                                                                              setState(() {
                                                                                FirebaseFirestore.instance.collection("users").doc(loggedInUser.uid).collection('Vehículos').doc(id_car).delete().then(
                                                                                      (doc) => print("Document deleted"),
                                                                                      onError: (e) => print("Error updating document $e"),
                                                                                    );

                                                                                FirebaseFirestore.instance.collection("carros").doc(id_car).delete().then(
                                                                                      (doc) => print("Document deleted"),
                                                                                      onError: (e) => print("Error updating document $e"),
                                                                                    );

                                                                                print('/${loggedInUser.uid}/images/Vehículo_${id_car}');

                                                                                firedelete(loggedInUser.uid.toString(), id_car, cant_fotos);

                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                                                                  content: Container(
                                                                                      width: double.infinity,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.delete,
                                                                                            size: 25,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                          Text('Vehículo Eliminado',
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
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.only(right: 13, top: 10, bottom: 10, left: 13),
                                                                              color: RED_CAR,
                                                                              child: Text(
                                                                                "Si",
                                                                                style: TextStyle(fontFamily: 'biko', color: Colors.white, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ));
                                                            },
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: -15,
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration:
                                                  BoxDecoration(color: RED_CAR),
                                              child: Text(
                                                "Detalles",
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ))));
              },
            );
          }
        }
      },
    );
  }
}
