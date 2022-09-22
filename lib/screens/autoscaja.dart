import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/infoAutos.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CajaAutos extends StatefulWidget {
  final String QueryTexto;

  CajaAutos({Key? key, required this.QueryTexto}) : super(key: key);

  @override
  State<CajaAutos> createState() => _CajaAutosState();
}

class _CajaAutosState extends State<CajaAutos> {
  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser = UserModel();

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('carros').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
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
        }

        var carros = snapshot.data;
        var t = widget.QueryTexto.toString().toLowerCase();
        var CarrosQuery = snapshot.data!.docs
            .where((e) =>
                e['nombre_carro'].toString().toLowerCase().contains(t) ||
                e['nombre_marca'].toString().toLowerCase().contains(t) ||
                e['precio'].toString().toLowerCase().contains(t) ||
                e['kilometraje'].toString().toLowerCase().contains(t) ||
                e['tipo_gasolina'].toString().toLowerCase().contains(t) ||
                e['color'].toString().toLowerCase().contains(t) ||
                e['porcentaje_descuento']
                    .toString()
                    .toLowerCase()
                    .contains(t) ||
                e['transmicion'].toString().toLowerCase().contains(t) ||
                e['traccion'].toString().toLowerCase().contains(t) ||
                e['carroceria'].toString().toLowerCase().contains(t))
            .toList();

        if (carros == null || CarrosQuery.isEmpty) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              widget.QueryTexto.isEmpty
                  ? 'No se han detectado vehículos registrados'
                  : "El vehículo que busca no está disponible",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'biko', fontSize: 22, color: Colors.black),
            ),
          );
        } else {
          return ListView.builder(
            itemCount:
                widget.QueryTexto.isEmpty ? carros.size : CarrosQuery.length,
            itemBuilder: (BuildContext context, int index) {
              var info_carro = snapshot.data!.docs[index];
              if (widget.QueryTexto.isNotEmpty) {
                info_carro = CarrosQuery[index];
              }
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
                                            id_visor:
                                                loggedInUser.uid.toString(),
                                            yo: loggedInUser.status.toString(),
                                            precio: numberFormat2(
                                                info_carro['precio']),
                                            Marca: info_carro['nombre_marca'],
                                            puertas:
                                                info_carro['numero_puertas'],
                                            Nombre: info_carro['nombre_carro'],
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
                                              info_carro['fotos'][0].toString(),
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
                                                            '${info_carro['nombre_marca']} ${info_carro['nombre_carro']}'
                                                                .toString()
                                                                .toTitleCase(),
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                        text:
                                                            '\$ ${numberFormat(promo)}',
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                        size: LABEL_SIZE * 1.5,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${info_carro['kilometraje']} km',
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
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: RED_CAR,
                                                        size: LABEL_SIZE * 1.5,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${info_carro['fecha_compra']}',
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
                                                        Icons.schema,
                                                        color: RED_CAR,
                                                        size: LABEL_SIZE * 1.5,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        info_carro[
                                                            'transmicion'],
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
                                                        size: LABEL_SIZE * 1.5,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        info_carro[
                                                            'ano_modelo'],
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
                                                        Icons.directions_car,
                                                        color: RED_CAR,
                                                        size: LABEL_SIZE * 1.5,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${info_carro['carroceria']}',
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
                                                        '${info_carro['nombre_marca']}'
                                                            .toTitleCase(),
                                                    style: TextStyle(
                                                        fontFamily: 'biko',
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              if (loggedInUser.status
                                                      .toString() ==
                                                  'Cliente')
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    height: 50,
                                                    child: StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .where('uid',
                                                                isEqualTo:
                                                                    loggedInUser
                                                                        .uid)
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot
                                                                snapshot2) {
                                                          if (!snapshot2
                                                              .hasData) {
                                                            return Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Center(
                                                                  child:
                                                                      Transform
                                                                          .scale(
                                                                scale: 1.6,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color:
                                                                      RED_CAR,
                                                                ),
                                                              )),
                                                            );
                                                          } else {
                                                            if (snapshot2
                                                                    .data!
                                                                    .docs
                                                                    .length ==
                                                                0) {
                                                              return Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20),
                                                                width: double
                                                                    .infinity,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'No',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'biko',
                                                                      fontSize:
                                                                          22,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              );
                                                            } else {
                                                              return ListView
                                                                  .builder(
                                                                      itemCount: snapshot2
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        QueryDocumentSnapshot<Object?>
                                                                            info_carro2 =
                                                                            snapshot2.data!.docs[index];
                                                                        return IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.favorite,
                                                                            size:
                                                                                35,
                                                                            color: info_carro2['Favoritos'].contains(info_carro['uid'])
                                                                                ? Colors.amber
                                                                                : Colors.black,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            if (info_carro2['Favoritos'].contains(info_carro['uid'])) {
                                                                              quitarFav(info_carro['nombre_carro'], info_carro['uid']);
                                                                            } else {
                                                                              agregarFav(info_carro['nombre_carro'].toString(), info_carro['uid'].toString());
                                                                            }
                                                                          },
                                                                        );
                                                                      });
                                                            }
                                                          }
                                                        }),
                                                  ),
                                                ),
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
                                          color:
                                              Color.fromARGB(255, 21, 110, 183),
                                        ),
                                        child: Text(
                                          "¡Promoción!",
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
                                        decoration:
                                            BoxDecoration(color: Colors.green),
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
                                          builder: (context, scrollController) {
                                            return SingleChildScrollView(
                                                controller: scrollController,
                                                child: AutosInfo(
                                                    id_visor: loggedInUser.uid
                                                        .toString(),
                                                    imagen: info_carro['fotos'],
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
                                                    garantia:
                                                        info_carro['garantia'],
                                                    puertas: info_carro[
                                                        'numero_puertas'],
                                                    Kilometraje:
                                                        '${info_carro['kilometraje']} km',
                                                    Gasolina: info_carro[
                                                        'tipo_gasolina'],
                                                    trans: info_carro[
                                                        'transmicion'],
                                                    Guia: info_carro[
                                                        'guia_mantenimiento'],
                                                    modelo: info_carro[
                                                        'ano_modelo'],
                                                    Fecha: info_carro[
                                                        'fecha_compra'],
                                                    potencia: '6.21/100 km',
                                                    traccion:
                                                        info_carro['traccion'],
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
                                                            text: '${info_carro['nombre_marca']} ${info_carro['nombre_carro']}'
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
                                                        alignment: Alignment
                                                            .centerLeft,
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
                                                          child: Row(children: [
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
                                                              color:
                                                                  Colors.black,
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
                                                              color:
                                                                  Colors.black,
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
                                                              color:
                                                                  Colors.black,
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
                                                    flex: 8,
                                                    child: Container(
                                                      child: TextParrafo(
                                                        text:
                                                            '${info_carro['nombre_marca']}'
                                                                .toTitleCase(),
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  if (loggedInUser.status
                                                          .toString() ==
                                                      'Cliente')
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: 50,
                                                        child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .where('uid',
                                                                    isEqualTo:
                                                                        loggedInUser
                                                                            .uid)
                                                                .snapshots(),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot
                                                                    snapshot2) {
                                                              if (!snapshot2
                                                                  .hasData) {
                                                                return Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Center(
                                                                      child: Transform
                                                                          .scale(
                                                                    scale: 1.6,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color:
                                                                          RED_CAR,
                                                                    ),
                                                                  )),
                                                                );
                                                              } else {
                                                                if (snapshot2
                                                                        .data!
                                                                        .docs
                                                                        .length ==
                                                                    0) {
                                                                  return Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    width: double
                                                                        .infinity,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'No',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'biko',
                                                                          fontSize:
                                                                              22,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return ListView
                                                                      .builder(
                                                                          itemCount: snapshot2
                                                                              .data!
                                                                              .docs
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            QueryDocumentSnapshot<Object?>
                                                                                info_carro2 =
                                                                                snapshot2.data!.docs[index];
                                                                            return IconButton(
                                                                              icon: Icon(
                                                                                Icons.favorite,
                                                                                size: 35,
                                                                                color: info_carro2['Favoritos'].contains(info_carro['uid']) ? Colors.amber : Colors.black,
                                                                              ),
                                                                              onPressed: () {
                                                                                if (info_carro2['Favoritos'].contains(info_carro['uid'])) {
                                                                                  quitarFav(info_carro['nombre_carro'], info_carro['uid']);
                                                                                } else {
                                                                                  agregarFav(info_carro['nombre_carro'].toString(), info_carro['uid'].toString());
                                                                                }
                                                                              },
                                                                            );
                                                                          });
                                                                }
                                                              }
                                                            }),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
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
                                          builder: (context, scrollController) {
                                            return SingleChildScrollView(
                                              controller: scrollController,
                                              child: AutosInfo(
                                                  imagen: info_carro['fotos'],
                                                  context: context,
                                                  id_visor: loggedInUser.uid
                                                      .toString(),
                                                  yo: loggedInUser.status
                                                      .toString(),
                                                  precio: numberFormat2(
                                                      info_carro['precio']),
                                                  Marca: info_carro[
                                                      'nombre_marca'],
                                                  Guia: info_carro[
                                                      'guia_mantenimiento'],
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
                                                  trans:
                                                      info_carro['transmicion'],
                                                  detalleprin: info_carro[
                                                      'detalle_principal'],
                                                  modelo:
                                                      info_carro['ano_modelo'],
                                                  garantia:
                                                      info_carro['garantia'],
                                                  detalles:
                                                      info_carro['detalles'],
                                                  Fecha: info_carro[
                                                      'fecha_compra'],
                                                  potencia: '6.21/100 km',
                                                  traccion:
                                                      info_carro['traccion'],
                                                  carroceria:
                                                      info_carro['carroceria'],
                                                  tipoCaja: info_carro[
                                                      'tipo_agregado']),
                                            );
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
                                                            text: '${info_carro['nombre_marca']} ${info_carro['nombre_carro']}'
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
                                                        alignment: Alignment
                                                            .centerLeft,
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
                                                                color: RED_CAR),
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
                                                                color: RED_CAR),
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
                                                          child: Row(children: [
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
                                                                .calendar_month_outlined,
                                                            color: RED_CAR,
                                                            size: LABEL_SIZE *
                                                                1.1,
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
                                                              color:
                                                                  Colors.black,
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
                                                              color:
                                                                  Colors.black,
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
                                                              color:
                                                                  Colors.black,
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
                                                    flex: 8,
                                                    child: Container(
                                                      child: TextParrafo(
                                                        text:
                                                            '${info_carro['nombre_marca']}'
                                                                .toTitleCase(),
                                                        style: TextStyle(
                                                            fontFamily: 'biko',
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  if (loggedInUser.status
                                                          .toString() ==
                                                      'Cliente')
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: 50,
                                                        child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .where('uid',
                                                                    isEqualTo:
                                                                        loggedInUser
                                                                            .uid)
                                                                .snapshots(),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot
                                                                    snapshot2) {
                                                              if (!snapshot2
                                                                  .hasData) {
                                                                return Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Center(
                                                                      child: Transform
                                                                          .scale(
                                                                    scale: 1.6,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color:
                                                                          RED_CAR,
                                                                    ),
                                                                  )),
                                                                );
                                                              } else {
                                                                if (snapshot2
                                                                        .data!
                                                                        .docs
                                                                        .length ==
                                                                    0) {
                                                                  return Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    width: double
                                                                        .infinity,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'No',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'biko',
                                                                          fontSize:
                                                                              22,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return ListView
                                                                      .builder(
                                                                          itemCount: snapshot2
                                                                              .data!
                                                                              .docs
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            QueryDocumentSnapshot<Object?>
                                                                                info_carro2 =
                                                                                snapshot2.data!.docs[index];
                                                                            return IconButton(
                                                                              icon: Icon(
                                                                                Icons.favorite,
                                                                                size: 35,
                                                                                color: info_carro2['Favoritos'].contains(info_carro['uid']) ? Colors.amber : Colors.black,
                                                                              ),
                                                                              onPressed: () {
                                                                                if (info_carro2['Favoritos'].contains(info_carro['uid'])) {
                                                                                  quitarFav(info_carro['nombre_carro'], info_carro['uid']);
                                                                                } else {
                                                                                  agregarFav(info_carro['nombre_carro'].toString(), info_carro['uid'].toString());
                                                                                }
                                                                              },
                                                                            );
                                                                          });
                                                                }
                                                              }
                                                            }),
                                                      ),
                                                    ),
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
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ],
                                  ))));
            },
          );
        }
      },
    );
  }

  Future agregarFav(
    String nombrecar,
    String idcar,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('users').doc(loggedInUser.uid).update({
      "Favoritos": FieldValue.arrayUnion([idcar])
    }).whenComplete(() {
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
                  Icons.favorite,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Agregado a sus favoritos',
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
  }

  Future quitarFav(
    String nombrecar,
    String idcar,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('users').doc(loggedInUser.uid).update({
      "Favoritos": FieldValue.arrayRemove([idcar])
    }).whenComplete(() {
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
                  Icons.favorite,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Eliminado de sus favoritos',
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
  }
}
