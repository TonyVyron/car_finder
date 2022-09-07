import 'dart:ffi';

import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class carrogeneral extends StatefulWidget {
  String id_vendedor;
  carrogeneral({Key? key, required this.id_vendedor}) : super(key: key);

  @override
  State<carrogeneral> createState() => _carrogeneralState();
}

class _carrogeneralState extends State<carrogeneral> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 180,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('carros')
              .where('uid_vendedor', isEqualTo: widget.id_vendedor)
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
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'No has registrado vehículos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'biko', fontSize: 22, color: Colors.black),
                  ),
                );
              } else {
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

                int forma(int? pordesc, int precio, int? porfalla) {
                  double promo = 0.0;
                  double descuento = 0.0;
                  double promo2 = 0.0;
                  double descuento2 = 0.0;
                  if (pordesc != null) {
                    descuento = (precio / 100) * pordesc;
                    promo = precio - descuento;

                    return promo.toInt();
                  } else {
                    if (porfalla != null)
                      descuento2 = (precio / 100) * porfalla;
                    promo2 = precio - descuento2;

                    return promo2.toInt();
                  }
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?> info_carro =
                          snapshot.data!.docs[index];
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
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
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: Image.network(
                                          info_carro['fotos'][0].toString(),
                                          fit: BoxFit.fill,
                                        ).image,
                                      )),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      info_carro['fotos'][0].toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '\$ ${numberFormat2(forma(info_carro['porcentaje_descuento'], info_carro['precio'], info_carro['porcentaje_falla']))}',
                                          style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${info_carro['nombre_marca']} ${info_carro['nombre_carro']}',
                                          style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${info_carro['kilometraje']}, ${info_carro['tipo_gasolina']}, ${info_carro['fecha_compra']}, ${info_carro['transmicion']}, Puertas ${info_carro['numero_puertas']}, ${info_carro['carroceria']}',
                                        style: TextStyle(
                                          fontFamily: 'biko',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
          }),
    );
  }
}
