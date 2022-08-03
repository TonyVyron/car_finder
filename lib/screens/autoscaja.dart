// ignore_for_file: deprecated_member_use

//import 'package:animate_do/animate_do.dart';
import 'package:car_finder/screens/infoAutos.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

bool _estrella = false;
bool _estrella2 = false;
bool _estrella3 = false;

class CajaAutos extends StatefulWidget {
  const CajaAutos({Key? key}) : super(key: key);

  @override
  State<CajaAutos> createState() => _CajaAutosState();
}

class _CajaAutosState extends State<CajaAutos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListView(
        children: [
          for (var i = 0; i < 3; i++)
            if (i == 0)
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return AutosInfo(
                              imagen:
                                  'https://www.bmw.com.do/content/bmw/marketLATAM/bmw_com_do/es_DO/topics/fascination-bmw/bmw-concept-vehicle/bmw-concept-i4-highlights/jcr:content/par/mosaicgallery_a072/items/mosaicgalleryitem_f6/image/mobile.transform/mosaic963/image.1584526806688.jpg',
                              context: context,
                              precio: '300,000',
                              Marca: 'BMW',
                              Nombre: 'iX1 x Drive30',
                              Kilometraje: '79,398',
                              Gasolina: 'Diesel',
                              Direccion: 'Villahermosa',
                              porcentaje: '10',
                              tipocarro: 'Coche',
                              tipouso: 'Familiar',
                              Fecha: '10/2018',
                              potencia: '4.21/100 km',
                              promocion: '270,000',
                              Guia: 'No',
                              traccion: 'Tracción Trasera',
                              carroceria: 'Coche Pequeño',
                              tipoCaja: i + 1);
                        });
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                      'https://www.bmw.com.do/content/bmw/marketLATAM/bmw_com_do/es_DO/topics/fascination-bmw/bmw-concept-vehicle/bmw-concept-i4-highlights/jcr:content/par/mosaicgallery_a072/items/mosaicgalleryitem_f6/image/mobile.transform/mosaic963/image.1584526806688.jpg',
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
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: 'BMW',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: LABEL_SIZE,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: 'iX1 xDrive30',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: LABEL_SIZE,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: '\$ 270,000',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: TextParrafo(
                                                    text: '\$ 300,000',
                                                    style: TextStyle(
                                                        fontFamily: 'biko',
                                                        fontSize: 18,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
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
                                              text: '79.398 km',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.av_timer_sharp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: '10/2018',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.date_range),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Diesel',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.local_gas_station),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Común',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.family_restroom),
                                        ),
                                      )
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
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.bolt),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Coche',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.directions_car),
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
                                            text: 'BMW ix1 xdrive30...'
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_SIZE,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.star,
                                              size: 35,
                                              color: _estrella == true
                                                  ? Colors.amber
                                                  : Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _estrella = !_estrella;
                                              });
                                              if (_estrella == true) {
                                                // Scaffold.of(context)
                                                //     .showSnackBar(SnackBar(
                                                //   backgroundColor: Colors.amber,
                                                //   shape: RoundedRectangleBorder(
                                                //       borderRadius:
                                                //           BorderRadius.only(
                                                //               topLeft: Radius
                                                //                   .circular(30),
                                                //               topRight: Radius
                                                //                   .circular(
                                                //                       30))),
                                                //   content: Container(
                                                //       width: double.infinity,
                                                //       child: Row(
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .spaceEvenly,
                                                //         children: [
                                                //           Icon(
                                                //             Icons.star,
                                                //             size: 35,
                                                //             color: Colors.black,
                                                //           ),
                                                //           Text(
                                                //               "Agregado a Favoritos",
                                                //               textAlign:
                                                //                   TextAlign
                                                //                       .center,
                                                //               style: TextStyle(
                                                //                 fontFamily:
                                                //                     'biko',
                                                //                 fontSize: 22,
                                                //                 color: Colors
                                                //                     .black,
                                                //               ))
                                                //         ],
                                                //       )),
                                                // ));
                                              } else {}
                                            },
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
                                  color: Color.fromARGB(255, 21, 110, 183),
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
                                decoration: BoxDecoration(color: Colors.green),
                                child: Text(
                                  "10 %",
                                  style: TextStyle(
                                      fontFamily: 'biko',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          )
                        ],
                      )))
            else if (i == 1)
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return AutosInfo(
                              imagen:
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/07_Chevrolet_Aveo.jpg/1200px-07_Chevrolet_Aveo.jpg',
                              context: context,
                              precio: '120,000',
                              Marca: 'Chevrolet',
                              Nombre: 'Aveo',
                              Kilometraje: '80,508 km',
                              Gasolina: 'Magna',
                              Direccion: 'Centro',
                              tipocarro: 'Coche',
                              tipouso: 'Familiar',
                              Fecha: '05/2016',
                              potencia: '6.21/100 km',
                              Guia: 'No',
                              traccion: 'Tracción Trasera',
                              carroceria: 'Coche Pequeño',
                              tipoCaja: i + 1);
                        });
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/07_Chevrolet_Aveo.jpg/1200px-07_Chevrolet_Aveo.jpg',
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
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: 'chevrolet'.toUpperCase(),
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: LABEL_SIZE,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: ' Aveo',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: LABEL_SIZE,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: TextParrafo(
                                                    text: '\$ 120,000',
                                                    style: TextStyle(
                                                        fontFamily: 'biko',
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
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
                                              text: '80.508 km',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.av_timer_sharp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: '05/2016',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.date_range),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Magna',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.local_gas_station),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Común',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.family_restroom),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: '6,21/100 km',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.bolt),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Coche',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.directions_car),
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
                                            text: 'chevrolet Aveo...'
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_SIZE,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.star,
                                              size: 35,
                                              color: _estrella2 == true
                                                  ? Colors.amber
                                                  : Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _estrella2 = !_estrella2;
                                              });
                                              if (_estrella2 == true) {
                                                // Scaffold.of(context)
                                                //     .showSnackBar(SnackBar(
                                                //   backgroundColor: Colors.amber,
                                                //   shape: RoundedRectangleBorder(
                                                //       borderRadius:
                                                //           BorderRadius.only(
                                                //               topLeft: Radius
                                                //                   .circular(30),
                                                //               topRight: Radius
                                                //                   .circular(
                                                //                       30))),
                                                //   content: Container(
                                                //       width: double.infinity,
                                                //       child: Row(
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .spaceEvenly,
                                                //         children: [
                                                //           Icon(
                                                //             Icons.star,
                                                //             size: 35,
                                                //             color: Colors.black,
                                                //           ),
                                                //           Text(
                                                //               "Agregado a Favoritos",
                                                //               textAlign:
                                                //                   TextAlign
                                                //                       .center,
                                                //               style: TextStyle(
                                                //                 fontFamily:
                                                //                     'biko',
                                                //                 fontSize: 22,
                                                //                 color: Colors
                                                //                     .black,
                                                //               ))
                                                //         ],
                                                //       )),
                                                // ));
                                              } else {}
                                            },
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
            else
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return AutosInfo(
                              imagen:
                                  'https://dealcar.mx/wp-content/uploads/2021/03/nissan-march-sense-blanco-2018-2-876x535.jpg',
                              context: context,
                              precio: '70,000',
                              Marca: 'Nissan',
                              promocion: '63,000',
                              Nombre: 'March',
                              Kilometraje: '110,390 km',
                              Gasolina: 'Magna',
                              Direccion: 'Macuspana',
                              tipocarro: 'Coche',
                              tipouso: 'Familiar',
                              Fecha: '12/2020',
                              potencia: '7.21/100 km',
                              detalleprin: 'Aire Acondicionado',
                              Guia: 'No',
                              detalles:
                                  'El aire acondicionado tiene fallos en algunas cosas pero de ahi en fuera todo bien',
                              traccion: 'Tracción Trasera',
                              carroceria: 'Coche Pequeño',
                              tipoCaja: i + 1);
                        });
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                      'https://dealcar.mx/wp-content/uploads/2021/03/nissan-march-sense-blanco-2018-2-876x535.jpg',
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
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: 'NISSAN',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: LABEL_SIZE,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: 'March',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: LABEL_SIZE,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  child: TextParrafo(
                                                    text: '\$ 63,000',
                                                    style: TextStyle(
                                                        fontFamily: 'biko',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: TextParrafo(
                                                    text: '10%',
                                                    style: TextStyle(
                                                        fontFamily: 'biko',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: RED_CAR),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: '\$ 70,000',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: 18,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    color: RED_CAR),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: TextParrafo(
                                                text: 'Aire Acondicionado',
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.italic,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: '110.390 km',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.av_timer_sharp),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: '12/2020',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.date_range),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Magna',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.local_gas_station),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Común',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.family_restroom),
                                        ),
                                      )
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
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.bolt),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextParrafo(
                                              text: 'Coche',
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                              icon: Icons.directions_car),
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
                                                'Nissan March...'.toUpperCase(),
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_SIZE,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.star,
                                              size: 35,
                                              color: _estrella3 == true
                                                  ? Colors.amber
                                                  : Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _estrella3 = !_estrella3;
                                              });
                                              if (_estrella3 == true) {
                                                // Scaffold.of(context)
                                                //     .showSnackBar(SnackBar(
                                                //   backgroundColor: Colors.amber,
                                                //   shape: RoundedRectangleBorder(
                                                //       borderRadius:
                                                //           BorderRadius.only(
                                                //               topLeft: Radius
                                                //                   .circular(30),
                                                //               topRight: Radius
                                                //                   .circular(
                                                //                       30))),
                                                //   content: Container(
                                                //       width: double.infinity,
                                                //       child: Row(
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .spaceEvenly,
                                                //         children: [
                                                //           Icon(
                                                //             Icons.star,
                                                //             size: 35,
                                                //             color: Colors.black,
                                                //           ),
                                                //           Text(
                                                //               "Agregado a Favoritos",
                                                //               textAlign:
                                                //                   TextAlign
                                                //                       .center,
                                                //               style: TextStyle(
                                                //                 fontFamily:
                                                //                     'biko',
                                                //                 fontSize: 22,
                                                //                 color: Colors
                                                //                     .black,
                                                //               ))
                                                //         ],
                                                //       )),
                                                // ));
                                              } else {}
                                            },
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
                                decoration: BoxDecoration(color: RED_CAR),
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
                      )))
        ],
      ),
    );
  }
}
