import 'package:animate_do/animate_do.dart';
import 'package:car_finder/imageupload/show_horizontal.dart';
import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

UserModel loggedInUser2 = UserModel();

Widget AutosInfo(
    {required BuildContext context,
    required int tipoCaja,
    String? Marca,
    String? Nombre,
    String? yo,
    String? Gasolina,
    String? promocion,
    String? precio,
    String? modelo,
    String? puertas,
    String? porcentaje,
    String? detalleprin,
    String? detalles,
    String? garantia,
    String? Kilometraje,
    String? Fecha,
    String? trans,
    String? potencia,
    String? carroceria,
    String? Guia,
    String? id_vendedor,
    required List<dynamic>? imagen,
    String? traccion}) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(id_vendedor)
      .get()
      .then((value) {
    loggedInUser2 = UserModel.fromMap(value.data());
  });

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
                        Nombre.toString(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                            color: RED_CAR),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Text(
                        Marca.toString(),
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
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
                              Icons.place,
                              color: Color.fromARGB(255, 5, 97, 173),
                              size: 30,
                            )),
                            Expanded(
                              child: Text(
                                "Tabasco/${loggedInUser2.Direcc.toString()}",
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
                    if (yo == 'Cliente') ...[
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(28, 0, 0, 0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      offset: Offset(-4, 4),
                                      blurRadius: 6.0,
                                    ),
                                  ]),
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    onPrimary: Colors.white,
                                    primary: Color.fromARGB(164, 0, 0, 0),
                                    shadowColor: Colors.black,
                                    elevation: 15,
                                  ),
                                  onPressed: () async {
                                    final Uri TelLaunchUri = Uri(
                                      scheme: 'tel',
                                      path: loggedInUser2.Telefono.toString(),
                                    );
                                    launchUrl(TelLaunchUri);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: double.infinity,
                                          child: Icon(
                                            Icons.phone,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          'Telefono',
                                          style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(28, 0, 0, 0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      offset: Offset(-4, 4),
                                      blurRadius: 6.0,
                                    ),
                                  ]),
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    onPrimary: Colors.white,
                                    primary: Color.fromARGB(164, 0, 0, 0),
                                    shadowColor: Colors.black,
                                    elevation: 15,
                                  ),
                                  onPressed: () async {
                                    String email =
                                        loggedInUser2.email.toString();
                                    String subject = 'Usuario Car Finder';
                                    String body =
                                        'Deseo Contactarle por el motivo de:\n';

                                    String? encodeQueryParameters(
                                        Map<String, String> params) {
                                      return params.entries
                                          .map((MapEntry<String, String> e) =>
                                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                          .join('&');
                                    }

                                    final Uri emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path: email,
                                      query: encodeQueryParameters(<String,
                                          String>{
                                        'subject': subject,
                                        'body': body,
                                      }),
                                    );

                                    launchUrl(emailLaunchUri);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: double.infinity,
                                          child: Icon(
                                            Icons.email,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          'Correo',
                                          style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black.withOpacity(.3),
                      )
                    ],
                    Row(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: TextParrafo(
                            text:
                                '\$ ${tipoCaja == 1 || tipoCaja == 3 ? promocion : precio}',
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: tipoCaja == 2 ? 34 : 32,
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
                                fontWeight: FontWeight.w500,
                                color: tipoCaja == 3 ? RED_CAR : Colors.black),
                          ),
                        ),
                    ]),
                    if (tipoCaja == 3)
                      Container(
                        width: double.infinity,
                        child: TextParrafo(
                          text: '${detalleprin}'.toTitleCase(),
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: tipoCaja == 3 ? RED_CAR : Colors.black),
                        ),
                      ),
                    Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(.3),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.av_timer_sharp,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Kilometraje",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          '${Kilometraje}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.local_gas_station,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Gasolina",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          '${Gasolina}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: 15,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
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
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "Fecha de Adquisición",
                                          textAlign: TextAlign.center,
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
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.directions_car,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Carrocería",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          '${carroceria}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
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
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.date_range,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Modelo",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          '${modelo}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.schema,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Transmición",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          '${trans}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
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
                    InkWell(
                      onTap: () {
                        if (yo == 'Cliente')
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    insetPadding: EdgeInsets.all(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/fondo.png'),
                                              fit: BoxFit.fill)),
                                      height: 400,
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 68,
                                              child: Container(
                                                height: 130,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Image.network(
                                                              loggedInUser2.foto
                                                                  .toString())
                                                          .image,
                                                      fit: BoxFit.cover),
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Text(
                                                loggedInUser2.NombreLocal
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: 22,
                                                    color: RED_CAR),
                                              ),
                                            ),
                                            Text(
                                              loggedInUser2.Telefono.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              loggedInUser2.Direcc.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              loggedInUser2.email.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'biko',
                                                  fontSize: LABEL_CAJA,
                                                  color: Colors.black),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                                'Puntuar Vendedor:'.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'biko',
                                                    fontSize: 22,
                                                    color: RED_CAR),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Icon(Icons.star,
                                                        size: 35,
                                                        color: Colors.amber),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Icon(Icons.star,
                                                        size: 35,
                                                        color: Colors.amber),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Icon(Icons.star,
                                                        size: 35,
                                                        color: Colors.amber),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Icon(Icons.star,
                                                        size: 35,
                                                        color: Colors.amber),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Icon(Icons.star,
                                                        size: 35,
                                                        color: Colors.amber),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              });
                      },
                      child: CircleAvatar(
                        radius: 45,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    Image.network(loggedInUser2.foto.toString())
                                        .image,
                                fit: BoxFit.cover),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child:
                              Icon(Icons.star, size: 35, color: Colors.amber),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child:
                              Icon(Icons.star, size: 35, color: Colors.amber),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child:
                              Icon(Icons.star, size: 35, color: Colors.amber),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child:
                              Icon(Icons.star, size: 35, color: Colors.amber),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child:
                              Icon(Icons.star, size: 35, color: Colors.amber),
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
                            Icons.verified_user,
                            size: 30,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'compra con Confianza'.toTitleCase(),
                            style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: RED_CAR,
                            ),
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
                                color: RED_CAR,
                                size: 30,
                              ),
                            ),
                            Text(
                              'Datos Basicos'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: RED_CAR,
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
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
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
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
                                  puertas.toString().toTitleCase(),
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
                        if (garantia != null) ...[
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19,
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
                                    garantia.toString().toTitleCase(),
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
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
                                  'Transmición'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
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
                                  '${trans}'.toTitleCase(),
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
                            color: RED_CAR,
                          ),
                        ),
                        Text(
                          'Historial de Vehículo'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: RED_CAR,
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
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
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
                              "Fecha de Adquisición".toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
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
                              'Año del Modelo'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
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
                              modelo.toString().toTitleCase(),
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
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
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
                              color: RED_CAR,
                            ),
                          ),
                          Text(
                            'Detalles'.toTitleCase(),
                            style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: RED_CAR,
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
                              color: Colors.black),
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
                            Icons.directions_car,
                            size: 30,
                            color: RED_CAR,
                          ),
                        ),
                        Text(
                          'Vehículos Similares'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: RED_CAR,
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
