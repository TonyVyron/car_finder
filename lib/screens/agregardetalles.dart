import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class agregarDetalles extends StatefulWidget {
  final String id_carro;
  agregarDetalles({Key? key, required this.id_carro}) : super(key: key);

  @override
  State<agregarDetalles> createState() => _agregarDetallesState();
}

class _agregarDetallesState extends State<agregarDetalles> {
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

  final _formkey = GlobalKey<FormState>();
  CarroModel carro = CarroModel();

  var detalles = TextEditingController();
  var detalle_prin = TextEditingController();
  var descuento_detalle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      '${carro.nombre_carro} ${carro.nombre_marca}',
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
                          },
                        ),
                      ))
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Text(
                        'Explicación del Detalle',
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 15),
                        textAlign: TextAlign.left,
                      )),
                  TextFormField(
                    autofocus: false,
                    controller: detalles,
                    onSaved: (value) {
                      detalles.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Detalles Vacios");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    maxLength: 150,
                    maxLines: 4,
                    style: TextStyle(
                        fontFamily: 'biko', fontWeight: FontWeight.w500),
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.details),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Fallo en la Apetura de puerta..",
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Text(
                        'Detalle Principal',
                        style: TextStyle(
                            fontFamily: 'biko',
                            color: Colors.black,
                            fontSize: 15),
                        textAlign: TextAlign.left,
                      )),
                  TextFormField(
                    maxLength: 50,
                    maxLines: 2,
                    autofocus: false,
                    controller: detalle_prin,
                    onSaved: (value) {
                      detalle_prin.text = value!;
                    },
                    style: TextStyle(
                        fontFamily: 'biko', fontWeight: FontWeight.w500),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Detalle Principal Vacio");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.dangerous),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Aire Acondicionado..",
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPrimary: Colors.white,
                  primary: RED_CAR,
                  shadowColor: Colors.white,
                  elevation: 15,
                ),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    agregardeta(
                        carro.uid.toString(), detalles.text, detalle_prin.text);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    "Agregar Descuento",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'biko',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  agregardeta(String carro, String detalles, String principal) async {
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
                Icons.details,
                size: 25,
                color: Colors.white,
              ),
              Text('Detalles Agregados',
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
    Navigator.pop(context);

    await firebaseFirestore.collection('carros').doc(carro).update({
      "tipo_agregado": 3,
      "detalles": detalles,
      "detalle_principal": principal,
      "porcentaje_falla": 4
    });
  }
}
