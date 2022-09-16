import 'dart:async';

import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class cambiarCor extends StatefulWidget {
  String oto;
  String id;
  String name;
  cambiarCor({
    Key? key,
    required this.oto,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<cambiarCor> createState() => _cambiarCorState();
}

class _cambiarCorState extends State<cambiarCor> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String apiKey = 'AIzaSyClliH9K6SFwgJHjaRdZyURL2BiAWJtB_Y';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DetailsResult? startPosition;
  late FocusNode startFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;
  var latitud = "";
  var longitud = "";

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -60,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: Image.network('${widget.oto}').image,
                ),
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    child: Text('Cambiar Dirección'.toTitleCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 25))),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    TextFormField(
                      autofocus: false,
                      controller: _nameController,
                      focusNode: startFocusNode,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontFamily: 'biko', fontWeight: FontWeight.w500),
                      onSaved: (value) {
                        _nameController.text = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Dirección Vacia");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: _nameController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    predictions = [];
                                    _nameController.clear();
                                  });
                                },
                                icon: Icon(Icons.clear_outlined),
                              )
                            : null,
                        prefixIcon: Icon(Icons.place),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: widget.name.toString(),
                        hintStyle: TextStyle(
                          fontFamily: 'biko',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          if (value.isNotEmpty) {
                            //places api
                            autoCompleteSearch(value);
                          } else {
                            //clear out the results
                            setState(() {
                              predictions = [];
                              startPosition = null;
                            });
                          }
                        });
                      },
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: predictions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.pin_drop, color: Colors.white),
                            ),
                            title: Text(
                              predictions[index].description.toString(),
                            ),
                            onTap: () async {
                              final placeId = predictions[index].placeId!;

                              final details =
                                  await googlePlace.details.get(placeId);
                              if (details != null &&
                                  details.result != null &&
                                  mounted) {
                                if (startFocusNode.hasFocus) {
                                  setState(() {
                                    startPosition = details.result;
                                    _nameController.text =
                                        details.result!.name!;
                                    latitud = details
                                        .result!.geometry!.location!.lat
                                        .toString();
                                    longitud = details
                                        .result!.geometry!.location!.lng
                                        .toString();

                                    predictions = [];
                                  });
                                }
                              }
                            },
                          );
                        }),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: RED_CAR,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        actuname();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cambiar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: Colors.black,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  actuname() async {
    if (_formkey.currentState!.validate()) {
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
                  Icons.place,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Dirección Actualizada',
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
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      Navigator.pop(context);

      await firebaseFirestore.collection('users').doc(widget.id).update({
        "Direcc": _nameController.text,
        'Cor_long': double.parse(longitud),
        'Cor_lat': double.parse(latitud),
      });
    }
  }
}

class actunamelocal extends StatefulWidget {
  String oto;
  String id;
  String name;

  actunamelocal({
    Key? key,
    required this.oto,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<actunamelocal> createState() => _actunamelocalState();
}

class _actunamelocalState extends State<actunamelocal> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -60,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: Image.network('${widget.oto}').image,
                ),
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    child: Text('Cambiar Nombre DEL lOCAL'.toTitleCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 25))),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    autofocus: false,
                    controller: _nameController,
                    onSaved: (value) {
                      _nameController.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Nombre del Local Vacio");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.store_mall_directory),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "${widget.name}",
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: RED_CAR,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        actuname();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cambiar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: Colors.black,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  actuname() async {
    if (_formkey.currentState!.validate()) {
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
                  Icons.store_mall_directory,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Local Actualizado',
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
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      Navigator.pop(context);

      await firebaseFirestore.collection('users').doc(widget.id).update({
        "NombreLocal": _nameController.text,
      });
    }
  }
}

class actunombre extends StatefulWidget {
  String oto;
  String id;
  String nombre;
  String apellido;
  actunombre(
      {Key? key,
      required this.oto,
      required this.id,
      required this.nombre,
      required this.apellido})
      : super(key: key);

  @override
  State<actunombre> createState() => _actunombreState();
}

class _actunombreState extends State<actunombre> {
  final _formkey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -60,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: Image.network('${widget.oto}').image,
                ),
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    child: Text('Cambiar Nombre Completo'.toTitleCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 25))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    child: Text('Nombre'.toTitleCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: LABEL_INFO))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    autofocus: false,
                    controller: _nombreController,
                    onSaved: (value) {
                      _nombreController.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Nombre Vacio");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "${widget.nombre}",
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    child: Text('Apellido'.toTitleCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: LABEL_INFO))),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    autofocus: false,
                    controller: _apellidoController,
                    onSaved: (value) {
                      _apellidoController.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Apellido Vacio");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.man),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "${widget.apellido}",
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: RED_CAR,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        actunombres();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cambiar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: Colors.black,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  actunombres() async {
    if (_formkey.currentState!.validate()) {
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
                  Icons.person,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Nombre Actualizado',
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
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      Navigator.pop(context);

      await firebaseFirestore.collection('users').doc(widget.id).update({
        "Apellidos": _apellidoController.text,
        "Nombre": _nombreController.text,
      });
    }
  }
}

class telefonoperson extends StatefulWidget {
  String oto;
  String id;
  String telefono;
  telefonoperson(
      {Key? key, required this.oto, required this.id, required this.telefono})
      : super(key: key);

  @override
  State<telefonoperson> createState() => _telefonopersonState();
}

class _telefonopersonState extends State<telefonoperson> {
  @override
  final _formkey = GlobalKey<FormState>();
  final _telefonoController = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -60,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: Image.network('${widget.oto}').image,
                ),
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    child: Text('Cambiar Teléfono'.toTitleCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 25))),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    autofocus: false,
                    controller: _telefonoController,
                    onSaved: (value) {
                      _telefonoController.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Telefono Vacio");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "${widget.telefono}",
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: RED_CAR,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        actunumero();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cambiar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: Colors.black,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  actunumero() async {
    if (_formkey.currentState!.validate()) {
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
                  Icons.phone,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Teléfono Actualizado',
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
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      Navigator.pop(context);

      await firebaseFirestore.collection('users').doc(widget.id).update({
        "Telefono": _telefonoController.text,
      });
    }
  }
}

class actuedad extends StatefulWidget {
  String oto;
  String id;
  String edad;
  actuedad({Key? key, required this.oto, required this.id, required this.edad})
      : super(key: key);

  @override
  State<actuedad> createState() => _actuedadState();
}

class _actuedadState extends State<actuedad> {
  @override
  final _formkey = GlobalKey<FormState>();
  final _edadController = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -60,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: Image.network('${widget.oto}').image,
                ),
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    child: Text('Cambiar Edad'.toTitleCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 25))),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    autofocus: false,
                    controller: _edadController,
                    onSaved: (value) {
                      _edadController.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Edad Vacio");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "${widget.edad}",
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: RED_CAR,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        actued();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cambiar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPrimary: Colors.white,
                        primary: Colors.black,
                        shadowColor: Colors.white,
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'biko',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  actued() async {
    if (_formkey.currentState!.validate()) {
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
                  Icons.date_range,
                  size: 25,
                  color: Colors.white,
                ),
                Text('Edad Actualizado',
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
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      Navigator.pop(context);

      await firebaseFirestore.collection('users').doc(widget.id).update({
        "Edad": _edadController.text,
      });
    }
  }
}
