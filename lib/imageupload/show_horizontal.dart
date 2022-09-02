import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class autosHorizontal extends StatefulWidget {
  autosHorizontal({Key? key}) : super(key: key);

  @override
  State<autosHorizontal> createState() => _autosHorizontalState();
}

class _autosHorizontalState extends State<autosHorizontal> {
  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser = UserModel();
  UserModel loggedInUser2 = UserModel();

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
      if (porfalla != null) descuento2 = (precio / 100) * porfalla;
      promo2 = precio - descuento2;

      return promo2.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('carros').limit(8).snapshots(),
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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                for (var i = 0; i < snapshot.data!.docs.length; i++)
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.5)),
                          color: Colors.white),
                      width: 200,
                      height: 300,
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Image.network(
                                snapshot.data!.docs[i]['fotos'][0].toString(),
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.maxFinite,
                              ),
                            ),
                          ),
                          Container(
                              height: 148,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '\$ ${numberFormat2(forma(snapshot.data!.docs[i]['porcentaje_descuento'], snapshot.data!.docs[i]['precio'], snapshot.data!.docs[i]['porcentaje_falla']))}',
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
                                      '${snapshot.data!.docs[i]['nombre_marca']} ${snapshot.data!.docs[i]['nombre_carro']}',
                                      style: TextStyle(
                                        fontFamily: 'biko',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data!.docs[i]['kilometraje']}, ${snapshot.data!.docs[i]['tipo_gasolina']}, ${snapshot.data!.docs[i]['fecha_compra']}, ${snapshot.data!.docs[i]['transmicion']}, Puertas ${snapshot.data!.docs[i]['numero_puertas']}, ${snapshot.data!.docs[i]['carroceria']}',
                                    style: TextStyle(
                                      fontFamily: 'biko',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  )
              ],
            ),
          );
        }
      },
    );
  }
}
