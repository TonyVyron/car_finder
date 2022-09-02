import 'dart:io';

import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AgregaFotos extends StatefulWidget {
  final String id_carro;
  AgregaFotos({Key? key, required this.id_carro}) : super(key: key);

  @override
  State<AgregaFotos> createState() => _AgregaFotosState();
}

class _AgregaFotosState extends State<AgregaFotos> {
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

  List<XFile>? _imageFileList = [];
  final imagePicker = ImagePicker();

  Future imagepickerMethod() async {
    final List<XFile>? selectimages = await imagePicker.pickMultiImage();
    setState(() {
      if (selectimages != null) {
        _imageFileList!.addAll(selectimages);
        print('Tamaño del Arreglo:' + _imageFileList!.length.toString());
      } else {
        showsnackbar(
            'Sin Imagen Detectada',
            Duration(milliseconds: 600),
            Icon(
              Icons.close,
              size: 25,
              color: Colors.white,
            ));
      }
    });
  }

  showsnackbar(String texto, Duration d, Icon ic) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: d,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      content: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ic,
              Text(texto,
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 500,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  '${carro.nombre_carro} ${carro.nombre_marca}',
                  style: TextStyle(
                      fontFamily: 'biko', fontSize: 25, color: Colors.black),
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
            onTap: () {
              imagepickerMethod();
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Subir Imagen del Vehículo",
                style: TextStyle(
                  fontFamily: 'biko',
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(5)),
            height: 300,
            alignment: Alignment.center,
            child: _imageFileList!.length > 0
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: _imageFileList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            File(_imageFileList![index].path),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(210, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(5)),
                                width: 35,
                                height: 35,
                                child: IconButton(
                                    color: RED_CAR,
                                    onPressed: () {
                                      _imageFileList!.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20,
                                    )),
                              ))
                        ],
                      );
                    },
                  )
                : Text(
                    "Sin Imagenes Subidas",
                    style: TextStyle(
                      fontFamily: 'biko',
                      fontSize: 20,
                    ),
                  ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPrimary: Colors.white,
                shadowColor: Colors.black,
                elevation: 15,
              ),
              onPressed: () {
                if (_imageFileList!.length > 0) {
                  agregarfoto(carro.uid_vendedor.toString(),
                      carro.uid.toString(), carro.fotos!.length.toInt());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
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
                            Text('No se Encuentran Fotos',
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
                }
              },
              child: Text(
                "Ingresar Fotos",
                style: TextStyle(fontFamily: 'biko', fontSize: 25),
              ),
            ),
          )
        ],
      ),
    );
  }

  agregarfoto(String id_persona, String id_carro, int largo) async {
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
              'Las Fotos Estan Siendo Agregadas..',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'biko', fontSize: 20),
            ),
          );
        });
    String? UrlImage;
    final List imagenes = [];
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    for (var i = 0; i < _imageFileList!.length; i++) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("${id_persona}/images")
          .child('Vehículo_${id_carro}')
          .child('Subido_${i + largo + 1}');
      await ref.putFile(File(_imageFileList![i].path));
      UrlImage = await ref.getDownloadURL();
      imagenes.add(UrlImage);

      await firebaseFirestore.collection('carros').doc(id_carro).update({
        "fotos": FieldValue.arrayUnion([UrlImage])
      });
    }

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
              Text('Fotos Agregadas',
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
  }
}
