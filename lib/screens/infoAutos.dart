import 'package:animate_do/animate_do.dart';
import 'package:car_finder/imageupload/show_horizontal.dart';
import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

Widget AutosInfo(
    {required BuildContext context,
    required int tipoCaja,
    String? Marca,
    String? Nombre,
    String? Gasolina,
    String? promocion,
    String? precio,
    String? Direccion,
    String? porcentaje,
    String? detalleprin,
    String? detalles,
    String? Kilometraje,
    String? Fecha,
    String? tipouso,
    String? imagenVendedor,
    String? potencia,
    String? carroceria,
    String? Guia,
    required List<dynamic>? imagen,
    String? traccion}) {
  return FadeIn(
      duration: Duration(milliseconds: 600),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                child: Container(
                  width: 32,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                  ),
                ),
              ),
              _swiper(tipos: tipoCaja, urll: imagen!, porce: porcentaje),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "${Marca}",
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "${Nombre}",
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                child: Icon(
                              Icons.add_location,
                              color: Color.fromARGB(255, 5, 97, 173),
                              size: 30,
                            )),
                            Expanded(
                              child: Text(
                                "Tabasco/${Direccion}",
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  fontSize: LABEL_CAJA,
                                  color: Color.fromARGB(255, 5, 97, 173),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    Row(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: TextParrafo(
                            text:
                                '\$ ${tipoCaja == 1 || tipoCaja == 3 ? promocion : precio}',
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: tipoCaja == 2 ? 36 : 32,
                                fontWeight: FontWeight.bold,
                                color: tipoCaja == 1
                                    ? Colors.green
                                    : tipoCaja == 2
                                        ? Colors.black
                                        : Colors.black),
                          ),
                        ),
                      ),
                      if (tipoCaja == 1 || tipoCaja == 3)
                        Container(
                          child: TextParrafo(
                            text: '\$ ${precio}',
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: 18,
                                decoration: TextDecoration.lineThrough,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: tipoCaja == 3 ? RED_CAR : Colors.black),
                          ),
                        ),
                    ]),
                    if (tipoCaja == 3)
                      Container(
                        width: double.infinity,
                        child: TextParrafo(
                          text: '${detalleprin}',
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: tipoCaja == 3 ? RED_CAR : Colors.black),
                        ),
                      ),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.av_timer_sharp,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Kilometraje",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${Kilometraje}',
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.local_gas_station,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Gasolina",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${Gasolina}',
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.date_range,
                                    size: 40,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Fecha Compra",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${Fecha}",
                                        style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.directions_car,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "Tipo de Auto",
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        '${carroceria}',
                                        style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: LABEL_CAJA,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.bolt,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "Potencia",
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        '${potencia}',
                                        style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: LABEL_CAJA,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.family_restroom,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "Tipo de Uso",
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        '${tipouso}',
                                        style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: LABEL_CAJA,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    CircleAvatar(
                      radius: 40,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.network(imagenVendedor.toString())
                                  .image,
                              fit: BoxFit.cover),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.wine_bar_outlined,
                            size: 30,
                          ),
                        ),
                        Text(
                          'compra con Confianza'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.directions_car,
                                size: 30,
                              ),
                            ),
                            Text(
                              'Datos Basicos'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'carrocería'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${carroceria}'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Número de Puertas'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '4'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Garantía'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '12 Meses'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Tracción'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${traccion}'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Estado'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${tipouso}'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.history,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Historial de Vehículo'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kilometraje'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${Kilometraje}'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Año'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${Fecha}'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Guía de Mantenimiento'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${Guia}'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    if (tipoCaja == 3) ...[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.history,
                              size: 30,
                            ),
                          ),
                          Text(
                            'Detalles'.toTitleCase(),
                            style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          '${detalles}'.toTitleCase(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: RED_CAR),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black.withOpacity(.3),
                      ),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.car_repair,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Vehículos Similares'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [],
                      ),
                    ),
                    autosHorizontal(),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ));
}

Widget _swiper({required int tipos, required List urll, String? porce}) {
  return Container(
    width: double.infinity,
    height: 230.0,
    child: Swiper(
      viewportFraction: 0.9,
      scale: 1,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(5),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  urll[index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.maxFinite,
                ),
              ),
              if (tipos == 1) ...[
                Positioned(
                  right: 15,
                  top: 10,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.green),
                      child: Text(
                        "${porce} %",
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
                Positioned(
                  left: 15,
                  top: 10,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 21, 110, 183),
                      ),
                      child: Text(
                        "Promoción",
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontSize: 20,
                            color: Colors.white),
                      )),
                ),
              ],
              if (tipos == 3) ...[
                Positioned(
                  right: 15,
                  top: 10,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: RED_CAR),
                      child: Text(
                        "${porce} %",
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
                Positioned(
                  left: 15,
                  top: 10,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: RED_CAR,
                      ),
                      child: Text(
                        'Detalles',
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontSize: 20,
                            color: Colors.white),
                      )),
                ),
              ],
              Positioned(
                bottom: 10,
                right: 15,
                child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.filter,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Text(
                          "${index + 1}/${urll.length}",
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
      itemCount: urll.length, //widget.noti.jsat_fname2.length
      control: SwiperControl(),
    ),
  );
}
