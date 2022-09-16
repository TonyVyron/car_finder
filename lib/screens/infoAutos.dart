import 'package:animate_do/animate_do.dart';
import 'package:car_finder/imageupload/show_horizontal.dart';
import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/carrosgeneral.dart';
import 'package:car_finder/screens/infovende.dart';
import 'package:car_finder/screens/mapa.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

UserModel loggedInUser2 = UserModel();

Widget AutosInfo(
    {required BuildContext context,
    required int tipoCaja,
    required String id_visor,
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
    required id_vendedor,
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
                                "Tabasco, en ${loggedInUser2.Direcc.toString()}",
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  fontSize: 18,
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
                                    String subject =
                                        'Información sobre vehículo en Car Finder';
                                    String body =
                                        'Buen día, por medio del presente solicito información acerca de:\n';

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
                        alignment: Alignment.topLeft,
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
                                fontSize: 17,
                                decoration: TextDecoration.lineThrough,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
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
                                    width: double.infinity,
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
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Kilometraje",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_CAJA,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
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
                                    width: double.infinity,
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
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Gasolina",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_CAJA,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
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
                                    width: double.infinity,
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
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "Fecha de Adquisición",
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${Fecha}",
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              fontSize: LABEL_CAJA,
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
                                    width: double.infinity,
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
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Carrocería",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_CAJA,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${carroceria}',
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black),
                                          ),
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
                                    width: double.infinity,
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
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Modelo",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_CAJA,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${modelo}',
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black),
                                          ),
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
                                    width: double.infinity,
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
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Transmición",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: 14.9,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${trans}',
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                fontSize: LABEL_CAJA,
                                                color: Colors.black),
                                          ),
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
                                    child: infovende(
                                      id_per: id_visor,
                                      id_vendedor: id_vendedor,
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
                    Container(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('estrellas')
                              .doc(id_vendedor)
                              .collection('personas')
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
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
                                QueryDocumentSnapshot<Object?> info_carro =
                                    snapshot.data!.docs[i];
                                print(info_carro['estrellas']);

                                estre += info_carro['estrellas'];
                              }

                              return RatingBarIndicator(
                                rating: snapshot.data!.docs.length != 0
                                    ? estre / snapshot.data!.docs.length
                                    : 5.0,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                              );
                            }
                          }),
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
                            Icons.shopping_bag,
                            size: 30,
                            color: RED_CAR,
                          ),
                        ),
                        Expanded(
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
                    carrogeneral(id_vendedor: id_vendedor),
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
                            'compra con confianza'.toTitleCase(),
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
                              'Datos básicos'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.5,
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
                                  'Número de puertas'.toTitleCase(),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: LABEL_INFO,
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
                                  "${puertas.toString().toTitleCase()} puertas",
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: LABEL_INFO,
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
                                    'Tiempo de garantía'.toTitleCase(),
                                    style: TextStyle(
                                      fontFamily: 'biko',
                                      fontWeight: FontWeight.w500,
                                      fontSize: LABEL_INFO,
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
                                      fontSize: LABEL_INFO,
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
                                    fontSize: LABEL_INFO,
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
                                    fontSize: LABEL_INFO,
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
                          'Historial'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.5,
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
                                fontSize: LABEL_INFO,
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
                                fontSize: LABEL_INFO,
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
                              "Fecha de adquisición".toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500,
                                fontSize: LABEL_INFO,
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
                                fontSize: LABEL_INFO,
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
                                fontWeight: FontWeight.w500,
                                fontSize: LABEL_INFO,
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
                                fontSize: LABEL_INFO,
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
                              'Guía de mantenimiento'.toTitleCase(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500,
                                fontSize: LABEL_INFO,
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
                                fontSize: LABEL_INFO,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.place,
                            size: 30,
                            color: RED_CAR,
                          ),
                        ),
                        Text(
                          'Se ubica en:'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.5,
                            color: RED_CAR,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   height: 250,
                    //   child: StreamBuilder(
                    //       stream: FirebaseFirestore.instance
                    //           .collection('users')
                    //           .where('uid', isEqualTo: id_vendedor)
                    //           .snapshots(),
                    //       builder:
                    //           (BuildContext context, AsyncSnapshot snapshot) {
                    //         if (!snapshot.hasData) {
                    //           return Container(
                    //             alignment: Alignment.center,
                    //             child: Center(
                    //                 child: Transform.scale(
                    //               scale: 1.6,
                    //               child: CircularProgressIndicator(
                    //                 color: RED_CAR,
                    //               ),
                    //             )),
                    //           );
                    //         } else {
                    //           if (snapshot.data!.docs.length == 0) {
                    //             return Container(
                    //               margin: EdgeInsets.symmetric(horizontal: 20),
                    //               width: double.infinity,
                    //               alignment: Alignment.center,
                    //               child: Text(
                    //                 'No has registrado vehículos',
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                     fontFamily: 'biko',
                    //                     fontSize: 22,
                    //                     color: Colors.black),
                    //               ),
                    //             );
                    //           } else {
                    //             return ListView.builder(
                    //                 itemCount: snapshot.data!.docs.length,
                    //                 itemBuilder:
                    //                     (BuildContext context, int index) {
                    // QueryDocumentSnapshot<Object?>
                    //     info_carro =
                    //     snapshot.data!.docs[index];
                    //                   return mapa(
                    //                       latitud: info_carro['Cor_lat'],
                    //                       longitud: info_carro['Cor_long'],
                    //                       nombre: info_carro['NombreLocal']);
                    //                 });
                    //           }
                    //         }
                    //       }),
                    // ),

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
                              fontSize: 18.5,
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
                              fontSize: LABEL_INFO,
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
                          'También te pueden interesar'.toTitleCase(),
                          style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.5,
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
      itemCount: urll.length,
      control: SwiperControl(),
    ),
  );
}
