import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class agregdesc extends StatefulWidget {
  final String id_carro;
  agregdesc({Key? key, required this.id_carro}) : super(key: key);

  @override
  State<agregdesc> createState() => _agregdescState();
}

class _agregdescState extends State<agregdesc> {
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

  var desc = TextEditingController();

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
              Container(
                  width: double.infinity,
                  child: Text(
                    'Descuento del vehículo',
                    style: TextStyle(
                        fontFamily: 'biko', color: Colors.black, fontSize: 15),
                    textAlign: TextAlign.left,
                  )),
              TextFormField(
                autofocus: false,
                style:
                    TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
                controller: desc,
                onSaved: (value) {
                  desc.text = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Descuento del Vehículo Vacio");
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.discount),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "10, 20, 30 ...",
                  hintStyle: TextStyle(
                    fontFamily: 'biko',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
                    agregardescuento(
                        carro.uid.toString(), int.parse(desc.text));
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    "Agregar un descuento",
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

  agregardescuento(String carro, int descuento) async {
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
                Icons.discount_rounded,
                size: 25,
                color: Colors.white,
              ),
              Text('Descuento aplicado',
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

    await firebaseFirestore
        .collection('carros')
        .doc(carro)
        .update({"tipo_agregado": 1, "porcentaje_descuento": descuento});
  }
}
