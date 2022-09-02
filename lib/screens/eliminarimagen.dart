import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ElimImage extends StatefulWidget {
  final String id_carro;
  ElimImage({Key? key, required this.id_carro}) : super(key: key);

  @override
  State<ElimImage> createState() => _ElimImageState();
}

class _ElimImageState extends State<ElimImage> {
  CarroModel carro = CarroModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("carros")
        .doc(widget.id_carro)
        .get()
        .then((value) {
      this.carro = CarroModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('carros')
            .where('uid', isEqualTo: widget.id_carro)
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

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                '${info_carro['nombre_carro']} ${info_carro['nombre_marca']}',
                                style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 25,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: RED_CAR,
                                    border: Border.all(),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ))
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Eliminar Imagenes",
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                for (var i = 0;
                                    i < info_carro['fotos'].length;
                                    i++)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      alignment: Alignment.topRight,
                                      height: 250,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          image: DecorationImage(
                                              image: Image.network(
                                                      info_carro['fotos'][i])
                                                  .image,
                                              fit: BoxFit.fill)),
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(right: 5, top: 5),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                210, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: IconButton(
                                            color: RED_CAR,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (_) => new AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            50))),
                                                            backgroundColor:
                                                                Colors.white,
                                                            title: Text(
                                                                "Desea Eliminar Esta Imagen",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'biko',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 25,
                                                                )),
                                                            content: Text(
                                                                "Se Eliminara Permanentemente",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'biko',
                                                                )),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    color:
                                                                        RED_CAR,
                                                                    child: Text(
                                                                      "No",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'biko',
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )),
                                                              TextButton(
                                                                onPressed: () {
                                                                  if (i == 0) {
                                                                    print(
                                                                        "no se puede");
                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {
                                                                    EliminarIma(
                                                                        info_carro['uid']
                                                                            .toString(),
                                                                        info_carro['fotos'][i]
                                                                            .toString(),
                                                                        i,
                                                                        info_carro['uid_vendedor']
                                                                            .toString());
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.only(
                                                                      right: 13,
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 13),
                                                                  color:
                                                                      RED_CAR,
                                                                  child: Text(
                                                                    "Si",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'biko',
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 35,
                                            )),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          }
        },
      ),
    );
  }

  Future EliminarIma(
      String idcar, String Foto, int Lugar, String id_persona) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -90,
                  child: Container(
                      child: Image(
                    image: AssetImage("assets/carros.png"),
                    width: 120,
                    height: 120,
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60, bottom: 30),
                  alignment: Alignment.center,
                  child: Center(
                      child: Transform.scale(
                    scale: 1.8,
                    child: CircularProgressIndicator(
                      color: RED_CAR,
                    ),
                  )),
                ),
              ],
            ),
            content: Text(
              'Las Fotos Estan Siendo Eliminadas..',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'biko', fontSize: 20),
            ),
          );
        });
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('carros').doc(idcar).update({
      "fotos": FieldValue.arrayRemove([Foto])
    });

    final storageRef = FirebaseStorage.instance.ref();

    final desertRef = storageRef
        .child("${id_persona}/images")
        .child('Vehículo_${idcar}')
        .child('Subido_${Lugar + 1}');

    await desertRef.delete().whenComplete(() {
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
                  Icons.filter,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Imagen Eliminada',
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
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context, rootNavigator: true).pop();
    });
  }
}
