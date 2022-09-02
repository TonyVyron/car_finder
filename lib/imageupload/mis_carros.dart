import 'package:car_finder/screens/actualizarauto.dart';
import 'package:car_finder/screens/agregarfotos.dart';
import 'package:car_finder/screens/eliminarimagen.dart';
import 'package:car_finder/screens/agregardescuento.dart';
import 'package:car_finder/screens/agregardetalles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/infoAutos.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class mis_carros extends StatefulWidget {
  mis_carros({Key? key}) : super(key: key);

  @override
  State<mis_carros> createState() => _mis_carrosState();
}

class _mis_carrosState extends State<mis_carros> {
  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser = UserModel();
  DateTime selectedDate = DateTime.now();

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
                                              trans: info_carro['transmicion'],
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
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 2),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                        child: Row(children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 3),
                                                        child: Icon(
                                                          Icons.av_timer_sharp,
                                                          color: RED_CAR,
                                                          size:
                                                              LABEL_SIZE * 1.5,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${info_carro['kilometraje']} km',
                                                          style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
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
                                                          Icons
                                                              .calendar_month_outlined,
                                                          color: RED_CAR,
                                                          size:
                                                              LABEL_SIZE * 1.5,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${info_carro['fecha_compra']}',
                                                          style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ])),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 2),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                        child: Row(children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 3),
                                                        child: Icon(
                                                          Icons
                                                              .local_gas_station,
                                                          color: RED_CAR,
                                                          size:
                                                              LABEL_SIZE * 1.5,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          info_carro[
                                                              'tipo_gasolina'],
                                                          style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
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
                                                          Icons.schema,
                                                          color: RED_CAR,
                                                          size:
                                                              LABEL_SIZE * 1.5,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          info_carro[
                                                              'transmicion'],
                                                          style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ])),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 2),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                        child: Row(children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 3),
                                                        child: Icon(
                                                          Icons.date_range,
                                                          color: RED_CAR,
                                                          size:
                                                              LABEL_SIZE * 1.5,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          info_carro[
                                                              'ano_modelo'],
                                                          style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
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
                                                          Icons.directions_car,
                                                          color: RED_CAR,
                                                          size:
                                                              LABEL_SIZE * 1.5,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${info_carro['carroceria']}',
                                                          style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize:
                                                                LABEL_CAJA,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ])),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
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
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all()),
                                                      child: IconButton(
                                                        icon: Icon(Icons.build,
                                                            size: 35,
                                                            color: Colors.blue),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft: Radius.circular(
                                                                              50),
                                                                          topRight:
                                                                              Radius.circular(50))),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return Dialog(
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))),
                                                                                    insetPadding: EdgeInsets.all(10),
                                                                                    child: ActuCarro(
                                                                                      id_carro: info_carro['uid'],
                                                                                    ));
                                                                              });
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(15),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 8,
                                                                                  child: Text(
                                                                                    "Actualizar Información",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      fontSize: 20,
                                                                                      fontFamily: 'biko',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 2,
                                                                                  child: Icon(
                                                                                    Icons.update,
                                                                                    size: 35,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Divider(
                                                                        thickness:
                                                                            2,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          removerdescuento(
                                                                              info_carro['uid']);
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(15),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 8,
                                                                                  child: Text(
                                                                                    "Remover Descuento",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      fontSize: 21,
                                                                                      fontFamily: 'biko',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 2,
                                                                                  child: Icon(
                                                                                    Icons.discount_rounded,
                                                                                    size: 35,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Divider(
                                                                        thickness:
                                                                            2,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(15),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 8,
                                                                                  child: Text(
                                                                                    "Actualizar Imagenes",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      fontSize: 20,
                                                                                      fontFamily: 'biko',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 2,
                                                                                  child: Icon(
                                                                                    Icons.filter,
                                                                                    size: 35,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                      Divider(
                                                                        thickness:
                                                                            2,
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                                                          onPrimary:
                                                                              Colors.white,
                                                                          primary:
                                                                              RED_CAR,
                                                                          shadowColor:
                                                                              Colors.white,
                                                                          elevation:
                                                                              15,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 15,
                                                                              horizontal: 10),
                                                                          child:
                                                                              Text(
                                                                            "Cancelar",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontFamily: 'biko',
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      )
                                                                    ],
                                                                  )),
                                                                );
                                                              });
                                                        },
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
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
                                                                              duration: Duration(seconds: 1),
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
                                                      trans: info_carro[
                                                          'transmicion'],
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
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons
                                                                  .av_timer_sharp,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${info_carro['kilometraje']} km',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons
                                                                  .calendar_month_outlined,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${info_carro['fecha_compra']}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
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
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons.schema,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              info_carro[
                                                                  'transmicion'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons.date_range,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              info_carro[
                                                                  'ano_modelo'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons
                                                                  .directions_car,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${info_carro['carroceria']}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.black,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 6,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border:
                                                                  Border.all()),
                                                          child: IconButton(
                                                            icon: Icon(
                                                                Icons.build,
                                                                size: 35,
                                                                color: Colors
                                                                    .blue),
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                              bottomLeft: Radius.circular(50),
                                                                              topRight: Radius.circular(50))),
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                              child: Column(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return Dialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))),
                                                                                        insetPadding: EdgeInsets.all(10),
                                                                                        child: ActuCarro(
                                                                                          id_carro: info_carro['uid'],
                                                                                        ));
                                                                                  });
                                                                            },
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 8,
                                                                                      child: Text(
                                                                                        "Actualizar Información",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 20,
                                                                                          fontFamily: 'biko',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Icon(
                                                                                        Icons.update,
                                                                                        size: 35,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return Dialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))),
                                                                                        insetPadding: EdgeInsets.all(10),
                                                                                        child: agregdesc(
                                                                                          id_carro: info_carro['uid'],
                                                                                        ));
                                                                                  });
                                                                            },
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 8,
                                                                                      child: Text(
                                                                                        "Agregar Descuento",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 21,
                                                                                          fontFamily: 'biko',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Icon(
                                                                                        Icons.discount_rounded,
                                                                                        size: 35,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))), insetPadding: EdgeInsets.all(10), child: agregarDetalles(id_carro: info_carro['uid']));
                                                                                  });
                                                                            },
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 8,
                                                                                      child: Text(
                                                                                        "Agregar Detalles",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 21,
                                                                                          fontFamily: 'biko',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Icon(
                                                                                        Icons.details,
                                                                                        size: 35,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return AlertDialog(
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))),
                                                                                      contentPadding: EdgeInsets.all(0),
                                                                                      content: SingleChildScrollView(
                                                                                          child: Column(
                                                                                        children: [
                                                                                          InkWell(
                                                                                            onTap: () {
                                                                                              showDialog(
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    return Dialog(
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))),
                                                                                                      insetPadding: EdgeInsets.all(10),
                                                                                                      child: Container(
                                                                                                        child: AgregaFotos(id_carro: info_carro['uid']),
                                                                                                      ),
                                                                                                    );
                                                                                                  });
                                                                                            },
                                                                                            child: Container(
                                                                                                padding: EdgeInsets.all(15),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      flex: 8,
                                                                                                      child: Text(
                                                                                                        "Agregar Fotos",
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          fontSize: 22,
                                                                                                          fontFamily: 'biko',
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 2,
                                                                                                      child: Icon(
                                                                                                        Icons.filter,
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
                                                                                              showDialog(
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))), insetPadding: EdgeInsets.all(10), child: ElimImage(id_carro: info_carro['uid']));
                                                                                                  });
                                                                                            },
                                                                                            child: Container(
                                                                                                padding: EdgeInsets.all(15),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      flex: 8,
                                                                                                      child: Text(
                                                                                                        "Eliminar Fotos",
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          fontSize: 22,
                                                                                                          fontFamily: 'biko',
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 2,
                                                                                                      child: Icon(
                                                                                                        Icons.close,
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
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                                                                              onPrimary: Colors.white,
                                                                                              primary: RED_CAR,
                                                                                              shadowColor: Colors.white,
                                                                                              elevation: 15,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                                                                              child: Text(
                                                                                                "Cancelar",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontFamily: 'biko',
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
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 8,
                                                                                      child: Text(
                                                                                        "Actualizar Imagenes",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 20,
                                                                                          fontFamily: 'biko',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Icon(
                                                                                        Icons.filter,
                                                                                        size: 35,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                                                              onPrimary: Colors.white,
                                                                              primary: RED_CAR,
                                                                              shadowColor: Colors.white,
                                                                              elevation: 15,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                                                              child: Text(
                                                                                "Cancelar",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontFamily: 'biko',
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          )
                                                                        ],
                                                                      )),
                                                                    );
                                                                  });
                                                            },
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
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
                                                                                  duration: Duration(seconds: 1),
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
                                        // Positioned(
                                        //   top: 10,
                                        //   left: -15,
                                        //   child: Container(
                                        //       padding: EdgeInsets.all(3),
                                        //       decoration: BoxDecoration(
                                        //         color: Colors.amber,
                                        //       ),
                                        //       child: Text(
                                        //         "Recomendación",
                                        //         style: TextStyle(
                                        //             fontFamily: 'biko',
                                        //             fontSize: 15,
                                        //             color: Colors.black),
                                        //       )),
                                        // ),
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
                                                      trans: info_carro[
                                                          'transmicion'],
                                                      detalleprin: info_carro[
                                                          'detalle_principal'],
                                                      modelo: info_carro[
                                                          'ano_modelo'],
                                                      garantia: info_carro[
                                                          'garantia'],
                                                      detalles: info_carro[
                                                          'detalles'],
                                                      Guia: info_carro[
                                                          'guia_mantenimiento'],
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
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons
                                                                  .av_timer_sharp,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${info_carro['kilometraje']} km',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons
                                                                  .calendar_month_outlined,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${info_carro['fecha_compra']}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
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
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons.schema,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              info_carro[
                                                                  'transmicion'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons.date_range,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              info_carro[
                                                                  'ano_modelo'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            child:
                                                                Row(children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 3),
                                                            child: Icon(
                                                              Icons
                                                                  .directions_car,
                                                              color: RED_CAR,
                                                              size: LABEL_SIZE *
                                                                  1.5,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${info_carro['carroceria']}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'biko',
                                                                fontSize:
                                                                    LABEL_CAJA,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.black,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 6,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border:
                                                                  Border.all()),
                                                          child: IconButton(
                                                            icon: Icon(
                                                                Icons.build,
                                                                size: 35,
                                                                color: Colors
                                                                    .blue),
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                              bottomLeft: Radius.circular(50),
                                                                              topRight: Radius.circular(50))),
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                              child: Column(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return Dialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topRight: Radius.circular(50))),
                                                                                        insetPadding: EdgeInsets.all(10),
                                                                                        child: ActuCarro(
                                                                                          id_carro: info_carro['uid'],
                                                                                        ));
                                                                                  });
                                                                            },
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 8,
                                                                                      child: Text(
                                                                                        "Actualizar Información",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 22,
                                                                                          fontFamily: 'biko',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Icon(
                                                                                        Icons.update,
                                                                                        size: 35,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              removerdetalles(info_carro['uid']);
                                                                            },
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 8,
                                                                                      child: Text(
                                                                                        "Remover Detalles",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 22,
                                                                                          fontFamily: 'biko',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Icon(
                                                                                        Icons.discount_rounded,
                                                                                        size: 35,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: Container(
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 8,
                                                                                      child: Text(
                                                                                        "Actualizar Imagenes",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 22,
                                                                                          fontFamily: 'biko',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Icon(
                                                                                        Icons.filter,
                                                                                        size: 35,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2,
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                                                              onPrimary: Colors.white,
                                                                              primary: RED_CAR,
                                                                              shadowColor: Colors.white,
                                                                              elevation: 15,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                                                              child: Text(
                                                                                "Cancelar",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontFamily: 'biko',
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          )
                                                                        ],
                                                                      )),
                                                                    );
                                                                  });
                                                            },
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
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
                                                                                  duration: Duration(seconds: 1),
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

  removerdescuento(String carro) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      content: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.discount_sharp,
                size: 25,
                color: Colors.white,
              ),
              Text('Descuento Removido',
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
    Navigator.pop(context);

    await firebaseFirestore
        .collection('carros')
        .doc(carro)
        .update({"tipo_agregado": 2, "porcentaje_descuento": null});
  }

  removerdetalles(String carro) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      content: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.details,
                size: 25,
                color: Colors.white,
              ),
              Text('Detalles Removidos',
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
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Navigator.pop(context);

    await firebaseFirestore.collection('carros').doc(carro).update({
      "tipo_agregado": 2,
      "porcentaje_falla": null,
      "detalles": null,
      "detalle_principal": null
    });
  }
}
