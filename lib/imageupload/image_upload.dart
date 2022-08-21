import 'dart:io';
import 'dart:math';

import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _image;
  String? UrlImage;

  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser = UserModel();

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

  final imagePicker = ImagePicker();

  Future imagepickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
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

  Future imagepickerCamara() async {
    final pick = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
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

  Future uploadImage() async {
    final PostId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${user.uid}/images")
        .child('Subido_$PostId');
    await ref.putFile(_image!);
    UrlImage = await ref.getDownloadURL();
    print(UrlImage);

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .collection('images')
        .add({'DownloadUrl': UrlImage}).whenComplete(() => showsnackbar(
            'Imagen Subida',
            Duration(milliseconds: 600),
            Icon(
              Icons.check,
              size: 25,
              color: Colors.white,
            )));
    setState(() {
      _image = null;
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
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 500,
            width: double.infinity,
            child: Column(
              children: [
                Text('Ver Imagen'),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(41, 244, 67, 54),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: _image == null
                                    ? Center(
                                        child: Text("Imagen No seleccionada"))
                                    : Image.file(_image!)),
                            ElevatedButton(
                                onPressed: () {
                                  imagepickerMethod();
                                },
                                child: Text("Elegir Imagen")),
                            ElevatedButton(
                                onPressed: () {
                                  imagepickerCamara();
                                },
                                child: Text("Tomar Imagen")),
                            ElevatedButton(
                                onPressed: () {
                                  if (_image != null) {
                                    uploadImage();
                                  } else {
                                    showsnackbar(
                                        'Imagen no Selecccionada',
                                        Duration(milliseconds: 600),
                                        Icon(
                                          Icons.close,
                                          size: 25,
                                          color: Colors.white,
                                        ));
                                  }
                                },
                                child: Text("Subir Imagen"))
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
