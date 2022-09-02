import 'dart:io';
import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Agregar_Carro extends StatefulWidget {
  Agregar_Carro({Key? key}) : super(key: key);

  @override
  State<Agregar_Carro> createState() => _Agregar_CarroState();
}

bool Detalles_ligth = false;
bool Descuento_ligth = false;
bool Guia_ligth = false;
bool Garantia_ligth = false;

class _Agregar_CarroState extends State<Agregar_Carro> {
  DateTime selectedDate = DateTime.now();
  DateTime modelo = DateTime(2022);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String ano = "2022";

  void _pickYear(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topRight: Radius.circular(50))),
          title: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: RED_CAR,
            ),
            child: Text('Seleccionar el año del modelo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'biko',
                  fontSize: 20,
                )),
          ),
          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: size.height / 3,
            width: size.width,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                ...List.generate(
                  50,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        ano = "${2022 - index}";
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text((2022 - index).toString(),
                              style: TextStyle(
                                fontFamily: 'biko',
                                fontSize: 15,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? agarra = await showDatePicker(
        context: context,
        initialDate: modelo,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (agarra != null && agarra != modelo) {
      setState(() {
        modelo = agarra;
      });
    }
  }

  int currentstep = 0;
  bool completo = true;

  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

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

  List<XFile>? _imageFileList = [];
  String? UrlImage;
  String Gasolina = 'Magna';
  String Trans = 'Manual';
  String carroceria = 'SUV';
  String estado = 'Excelentes';
  String traccion = 'Trasera';

  final imagePicker = ImagePicker();

  final _nombreCarroController = TextEditingController();
  final _nombreMarcaController = TextEditingController();
  final _tiempogarantia = TextEditingController();
  final _precioController = TextEditingController();
  final _kilometrajeController = TextEditingController();
  final _ano_modeloController = TextEditingController();
  final _colorController = TextEditingController();
  final _numero_puertasController = TextEditingController();
  final _fecha_compraController = TextEditingController();
  final _detalles_compraController = TextEditingController();
  final _porcentaje_descuentoController = TextEditingController();
  final _detalle_prinController = TextEditingController();

  Future imagepickerMethod() async {
    final List<XFile>? selectimages = await imagePicker.pickMultiImage();
    setState(() {
      if (selectimages != null) {
        _imageFileList!.addAll(selectimages);
        print('Tamaño del Arreglo:' + _imageFileList!.length.toString());
      } else {
        showsnackbar(
            'No se detectó imagen',
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
        width: double.infinity,
        child: completo
            ? Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/carros.png',
                          width: 220,
                          height: 220,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: .5),
                              borderRadius: BorderRadius.circular(8),
                              color: RED_CAR,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(-4, 4),
                                  blurRadius: 15.0,
                                ),
                              ]),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                onPrimary: Colors.white,
                                primary: RED_CAR,
                                shadowColor: Colors.black,
                                elevation: 20,
                              ),
                              onPressed: () => setState(() {
                                    completo = false;
                                    currentstep = 0;
                                    _nombreCarroController.clear();
                                    _nombreMarcaController.clear();
                                    _precioController.clear();
                                    _kilometrajeController.clear();
                                    _ano_modeloController.clear();
                                    _colorController.clear();
                                    _detalles_compraController.clear();
                                    _fecha_compraController.clear();
                                    _numero_puertasController.clear();
                                    Guia_ligth = false;
                                    Detalles_ligth = false;
                                    Garantia_ligth = false;
                                    Descuento_ligth = false;
                                    _imageFileList = [];
                                  }),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.directions_car,
                                        size: 30,
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Agregar un nuevo vehículo',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'biko',
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Stepper(
                steps: getSteps(),
                type: StepperType.horizontal,
                currentStep: currentstep,
                onStepContinue: () {
                  if (currentstep == 0) {
                    if (_formkey.currentState!.validate()) {
                      setState(() => currentstep += 1);
                    }
                  } else {
                    if (currentstep == 1) {
                      if (_formkey2.currentState!.validate()) {
                        setState(() => currentstep += 1);
                      }
                    } else {
                      if (currentstep == 2) {
                        if (_imageFileList!.length > 0) {
                          if (_formkey2.currentState!.validate() &&
                              _formkey.currentState!.validate()) {
                            setState(() {
                              completo = true;
                              postCarrosDetails();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              content: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.close,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      Text('Tiene datos sin rellenar',
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
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            content: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    Text('Suba una foto',
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
                      } else {
                        setState(() => currentstep += 1);
                      }
                    }
                  }
                },
                onStepCancel: () {
                  currentstep == 0 ? null : setState(() => currentstep -= 1);
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  final islastStep2 = currentstep == getSteps().length - 1;
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onPrimary: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 5,
                          ),
                          child: Text(
                            islastStep2 ? "Confirmar" : "Siguiente",
                            style: TextStyle(fontFamily: 'biko', fontSize: 20),
                          ),
                          onPressed: details.onStepContinue,
                        )),
                        SizedBox(width: 12),
                        if (currentstep != 0)
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPrimary: Colors.white,
                              shadowColor: Colors.black,
                              elevation: 5,
                            ),
                            child: Text(
                              "Atrás",
                              style:
                                  TextStyle(fontFamily: 'biko', fontSize: 20),
                            ),
                            onPressed: details.onStepCancel,
                          )),
                      ],
                    ),
                  );
                },
              ));
  }

  List<Step> getSteps() => [
        Step(
            title: Text(
              "Básico",
              style: TextStyle(fontFamily: 'biko', fontSize: 16),
            ),
            state: currentstep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentstep >= 0,
            content: Container(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    //NOMBRE CARRO
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Modelo del vehículo',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        TextFormField(
                          autofocus: false,
                          style: TextStyle(
                              fontFamily: 'biko', fontWeight: FontWeight.w500),
                          controller: _nombreCarroController,
                          onSaved: (value) {
                            _nombreCarroController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("No ha puesto el modelo");
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.directions_car),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Por ejemplo Aveo o Sentra..",
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
                              'Marca',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        TextFormField(
                          autofocus: false,
                          style: TextStyle(
                              fontFamily: 'biko', fontWeight: FontWeight.w500),
                          textCapitalization: TextCapitalization.sentences,
                          controller: _nombreMarcaController,
                          onSaved: (value) {
                            _nombreMarcaController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("No ha escrito la marca");
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.discount_rounded),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Un ejemplo es Chevrolet...",
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
                    //PRECIO

                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Precio',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        TextFormField(
                          autofocus: false,
                          style: TextStyle(
                              fontFamily: 'biko', fontWeight: FontWeight.w500),
                          controller: _precioController,
                          onSaved: (value) {
                            _precioController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("el precio está vacío");
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.payment),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "68000..",
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
                    ), //KILOMETRAJE
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Kilometraje',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        TextFormField(
                          autofocus: false,
                          style: TextStyle(
                              fontFamily: 'biko', fontWeight: FontWeight.w500),
                          controller: _kilometrajeController,
                          onSaved: (value) {
                            _kilometrajeController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Kilometraje Vacio");
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.av_timer_sharp),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "80,000, 90,000...",
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
                    //TIPO USO
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Transmición',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(.4)),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          child: DropdownButton<String>(
                            value: Trans,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                Trans = newValue!;
                              });
                            },
                            items: <String>[
                              'Manual',
                              'Automático',
                              'CVT',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //TIPO GASOLINA
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Tipo de combustible',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(.4)),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          child: DropdownButton<String>(
                            value: Gasolina,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                Gasolina = newValue!;
                              });
                            },
                            items: <String>[
                              'Magna',
                              'Premium',
                              'Magna o Premium',
                              'Diesel'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //TIPO GASOLINA
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Carrocería',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(.4)),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          child: DropdownButton<String>(
                            value: carroceria,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                carroceria = newValue!;
                              });
                            },
                            items: <String>[
                              'SUV',
                              'Hatchback',
                              'Crossover',
                              'Convertible',
                              'Sedan',
                              'Deportivo',
                              'Coupe',
                              'Minivan',
                              'Station Wagon',
                              'Camionetas Pickup'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                          "Año",
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 15),
                          textAlign: TextAlign.left,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPrimary: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 5,
                              ),
                              onPressed: () {
                                _pickYear(context);
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'Elige el año',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'biko', fontSize: 16),
                                ),
                              )),
                        ),
                        Expanded(
                            child: Text(
                          "${ano}",
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Container(
                        width: double.infinity,
                        child: Text(
                          "Fecha de adquisición del vehículo",
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 15),
                          textAlign: TextAlign.left,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPrimary: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 5,
                              ),
                              onPressed: () {
                                _selectDate(context);
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'Seleccione la fecha',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'biko', fontSize: 16),
                                ),
                              )),
                        ),
                        Expanded(
                            child: Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Color',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        TextFormField(
                          autofocus: false,
                          style: TextStyle(
                              fontFamily: 'biko', fontWeight: FontWeight.w500),
                          controller: _colorController,
                          onSaved: (value) {
                            _colorController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Color del Vehículo Vacio");
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.color_lens),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Negro, Azul, Rojo..",
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
                    ), //TIPO GASOLINA
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Tracción',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(.4)),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          child: DropdownButton<String>(
                            value: traccion,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                traccion = newValue!;
                              });
                            },
                            items: <String>[
                              'Trasera',
                              'Delantera',
                              'Total',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                              'Número de puertas',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        TextFormField(
                          autofocus: false,
                          style: TextStyle(
                              fontFamily: 'biko', fontWeight: FontWeight.w500),
                          controller: _numero_puertasController,
                          onSaved: (value) {
                            _numero_puertasController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Numero de Puertas Vacio");
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.car_repair),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "4..",
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
                  ],
                ),
              ),
            )),
        Step(
            state: currentstep > 1 ? StepState.complete : StepState.indexed,
            title: Text(
              "Legal",
              style: TextStyle(fontFamily: 'biko', fontSize: 16),
            ),
            isActive: currentstep >= 1,
            content: Container(
              child: Form(
                key: _formkey2,
                child: Column(
                  children: [
                    if (Descuento_ligth == false) ...[
                      Container(
                        alignment: Alignment(0, 0),
                        height: 50,
                        margin: new EdgeInsets.only(bottom: 2),
                        padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Text(
                                  "¿Cuenta con algún detalle?",
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment(0, 0),
                                height: 50,
                                child: Switch(
                                    activeColor: RED_CAR,
                                    value: Detalles_ligth,
                                    onChanged: (state) {
                                      setState(() {
                                        Detalles_ligth = !Detalles_ligth;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                    if (Detalles_ligth == true) ...[
                      Column(
                        children: [
                          Container(
                              width: double.infinity,
                              child: Text(
                                '¿Cuál es este detalle?',
                                style: TextStyle(
                                    fontFamily: 'biko',
                                    color: Colors.black,
                                    fontSize: 15),
                                textAlign: TextAlign.left,
                              )),
                          TextFormField(
                            autofocus: false,
                            controller: _detalles_compraController,
                            onSaved: (value) {
                              _detalles_compraController.text = value!;
                            },
                            validator: Detalles_ligth == true
                                ? (value) {
                                    if (value!.isEmpty) {
                                      return ("Detalles Vacios");
                                    }
                                    return null;
                                  }
                                : null,
                            keyboardType: TextInputType.name,
                            maxLength: 150,
                            maxLines: 4,
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500),
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.details),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Problemas al abrir alguna puerta..",
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
                      Column(
                        children: [
                          Container(
                              width: double.infinity,
                              child: Text(
                                'Detalle principal',
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
                            controller: _detalle_prinController,
                            onSaved: (value) {
                              _detalle_prinController.text = value!;
                            },
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500),
                            validator: Detalles_ligth == true
                                ? (value) {
                                    if (value!.isEmpty) {
                                      return ("Detalle Principal Vacio");
                                    }
                                    return null;
                                  }
                                : null,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.drive_eta),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Aire acondicionado..",
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
                    ],
                    if (Detalles_ligth == false) ...[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment(0, 0),
                        height: 50,
                        margin: new EdgeInsets.only(bottom: 2),
                        padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Text(
                                  "¿Va a realizar algún descuento?",
                                  //(theme.isLighted() ? "Modo " : "Modo Normal"),
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment(0, 0),
                                height: 50,
                                child: Switch(
                                    activeColor: RED_CAR,
                                    value: Descuento_ligth,
                                    onChanged: (state) {
                                      setState(() {
                                        Descuento_ligth = !Descuento_ligth;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    SizedBox(
                      height: 10,
                    ),
                    if (Descuento_ligth == true && Detalles_ligth == false)
                      Column(
                        children: [
                          Container(
                              width: double.infinity,
                              child: Text(
                                'Porcentaje de descuento',
                                style: TextStyle(
                                    fontFamily: 'biko',
                                    color: Colors.black,
                                    fontSize: 15),
                                textAlign: TextAlign.left,
                              )),
                          TextFormField(
                            autofocus: false,
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500),
                            controller: _porcentaje_descuentoController,
                            onSaved: (value) {
                              _porcentaje_descuentoController.text = value!;
                            },
                            validator: Descuento_ligth == true &&
                                    Detalles_ligth == false
                                ? (value) {
                                    if (value!.isEmpty) {
                                      return ("Porcentaje de Descuento Vacio");
                                    }
                                    return null;
                                  }
                                : null,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.discount),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "5%, 10%, 20%..",
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
                    Container(
                      alignment: Alignment(0, 0),
                      height: 50,
                      margin: new EdgeInsets.only(bottom: 2),
                      padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text(
                                "¿Cuenta con la guía de mantenimiento?",
                                //(theme.isLighted() ? "Modo " : "Modo Normal"),
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment(0, 0),
                              height: 50,
                              child: Switch(
                                  activeColor: RED_CAR,
                                  value: Guia_ligth,
                                  onChanged: (state) {
                                    setState(() {
                                      Guia_ligth = !Guia_ligth;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ), //TIPO GASOLINA
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Text(
                              'Condiciones del vehículo',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(.4)),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          child: DropdownButton<String>(
                            value: estado,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                estado = newValue!;
                              });
                            },
                            items: <String>[
                              'Excelentes',
                              'Óptimas',
                              'Correctas',
                              'Con detalles',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      height: 50,
                      margin: new EdgeInsets.only(bottom: 2),
                      padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: Text(
                                "¿Cuenta con garantía?",
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment(0, 0),
                              height: 50,
                              child: Switch(
                                  activeColor: RED_CAR,
                                  value: Garantia_ligth,
                                  onChanged: (state) {
                                    setState(() {
                                      Garantia_ligth = !Garantia_ligth;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (Garantia_ligth == true)
                      Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: double.infinity,
                              child: Text(
                                'Tiempo de garantia',
                                style: TextStyle(
                                    fontFamily: 'biko',
                                    color: Colors.black,
                                    fontSize: 15),
                                textAlign: TextAlign.left,
                              )),
                          TextFormField(
                            autofocus: false,
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500),
                            controller: _tiempogarantia,
                            onSaved: (value) {
                              _tiempogarantia.text = value!;
                            },
                            validator: Garantia_ligth == true
                                ? (value) {
                                    if (value!.isEmpty) {
                                      return ("Tiempo de Garantia Vacia");
                                    }
                                    return null;
                                  }
                                : null,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.garage),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "6 Meses, 4 Meses..",
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
                    Image.asset(
                      'assets/carros.png',
                      width: 220,
                      height: 220,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            )),
        Step(
            state: currentstep > 2 ? StepState.complete : StepState.indexed,
            title: Text(
              "Imagen",
              style: TextStyle(fontFamily: 'biko', fontSize: 16),
            ),
            isActive: currentstep >= 2,
            content: Container(
              child: Column(
                children: [
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
                        "Subir imagen del vehículo",
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                            color: Color.fromARGB(
                                                210, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                ],
              ),
            ))
      ];

  postCarrosDetails() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
              'Estamos registrando la información...',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'biko', fontSize: 20),
            ),
          );
        });
    CarroModel carroModel = CarroModel();

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('carros').doc();

    final List imagenes = [];
    for (var i = 0; i < _imageFileList!.length; i++) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("${user.uid}/images")
          .child('Vehículo_${documentReference.id}')
          .child('subido_${i + 1}');
      await ref.putFile(File(_imageFileList![i].path));
      UrlImage = await ref.getDownloadURL();
      imagenes.add(UrlImage);
      print(imagenes[i].toString());
    }

    carroModel.fotos = imagenes;
    carroModel.uid = documentReference.id;
    carroModel.uid_vendedor = user.uid;
    carroModel.nombre_carro = _nombreCarroController.text;
    carroModel.nombre_marca = _nombreMarcaController.text;
    carroModel.precio = int.parse(_precioController.text);
    carroModel.kilometraje = _kilometrajeController.text;
    carroModel.tipo_gasolina = Gasolina;
    carroModel.carroceria = carroceria;
    carroModel.transmicion = Trans;
    carroModel.ano_modelo = ano;
    carroModel.color = _colorController.text;
    carroModel.numero_puertas = _numero_puertasController.text;
    carroModel.traccion = traccion;
    carroModel.fecha_compra =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    carroModel.guia_mantenimiento = Guia_ligth == true ? "Si" : "No";
    carroModel.estado_porcentaje = estado;

    if (Garantia_ligth == true) {
      carroModel.garantia = _tiempogarantia.text;
    }

    if (Descuento_ligth == true && Detalles_ligth == false) {
      carroModel.porcentaje_descuento =
          int.parse(_porcentaje_descuentoController.text);
      carroModel.tipo_agregado = 1;
    } else {
      if (Detalles_ligth == true && Descuento_ligth == false) {
        carroModel.detalles = _detalles_compraController.text;
        carroModel.detalle_principal = _detalle_prinController.text;
        carroModel.porcentaje_falla = 4;
        carroModel.tipo_agregado = 3;
      } else {
        carroModel.tipo_agregado = 2;
      }
    }

    await firebaseFirestore
        .collection('carros')
        .doc(documentReference.id)
        .set(carroModel.toMap());

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .collection('Vehículos')
        .doc(documentReference.id)
        .set({
      'nombre_carro': _nombreCarroController.text,
      'uid_carro': documentReference.id
    });
    Navigator.pop(context);
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
                Icons.check,
                size: 25,
                color: Colors.white,
              ),
              Text('Registrado con éxito',
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
}
