import 'package:car_finder/models/carro_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActuCarro extends StatefulWidget {
  final String id_carro;
  ActuCarro({Key? key, required this.id_carro}) : super(key: key);

  @override
  State<ActuCarro> createState() => _ActuCarroState();
}

class _ActuCarroState extends State<ActuCarro> {
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

  DateTime selectedDate = DateTime.now();
  DateTime modelo = DateTime(2022);
  bool Fecha_ahora = false;
  bool ano_ahora = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        Fecha_ahora = true;
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
            child: Text('Seleccionar Año del Modelo',
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
                        ano_ahora = true;
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

  final _formkey = GlobalKey<FormState>();
  CarroModel carro = CarroModel();
  var Nombre = TextEditingController();
  var Marca = TextEditingController();
  var Precio = TextEditingController();
  final _porcentaje_descuentoController = TextEditingController();
  var Kilometraje = TextEditingController();
  var _numero_puertasController = TextEditingController();
  var _colorController = TextEditingController();
  var _tiempogarantia = TextEditingController();
  final _detalle_prinController = TextEditingController();
  final _detalles_compraController = TextEditingController();
  bool trans_ligth = false;
  String transmicion = 'Manual';
  bool gas_ligth = false;
  String Gasolina = 'Magna';
  bool carr_ligth = false;
  String carroceria = 'SUV';
  bool tracc_ligth = false;
  String traccion = 'Trasera';
  bool estado_ligth = false;
  String estado = 'Excelentes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formkey,
      floatingActionButton: Container(
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPrimary: Colors.white,
              primary: Color.fromARGB(180, 192, 0, 0),
              shadowColor: Colors.black,
              elevation: 20,
            ),
            onPressed: () {
              UpdateCarrosDetails();
            },
            child: Text(
              "Actualizar datos",
              style: TextStyle(fontFamily: 'biko', fontSize: 20),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Form(
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
                Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                        width: double.infinity,
                        child: Text(
                          'Nombre del vehículo',
                          style: TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 15),
                          textAlign: TextAlign.left,
                        )),
                    TextFormField(
                      style: TextStyle(
                          fontFamily: 'biko', fontWeight: FontWeight.w500),
                      controller: Nombre,
                      onSaved: (value) {
                        Nombre.text = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Nombre del Vehículo Vacio");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.directions_car),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "${carro.nombre_carro}",
                        hintStyle: TextStyle(
                          fontFamily: 'biko',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                if (carro.tipo_agregado == 3) ...[
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          child: Text(
                            'Explicación del o sus detalles',
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
                        keyboardType: TextInputType.name,
                        maxLength: 150,
                        maxLines: 4,
                        style: TextStyle(
                            fontFamily: 'biko', fontWeight: FontWeight.w500),
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.dangerous),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "${carro.detalles}",
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
                            fontFamily: 'biko', fontWeight: FontWeight.w500),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.details),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "${carro.detalle_principal}",
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
                if (carro.tipo_agregado == 1) ...[
                  Column(
                    children: [
                      SizedBox(height: 10),
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
                            fontFamily: 'biko', fontWeight: FontWeight.w500),
                        controller: _porcentaje_descuentoController,
                        onSaved: (value) {
                          _porcentaje_descuentoController.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Porcentaje Vacio");
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.discount),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "${carro.porcentaje_descuento}",
                          hintStyle: TextStyle(
                            fontFamily: 'biko',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
                Column(
                  children: [
                    SizedBox(height: 10),
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
                      controller: Marca,
                      onSaved: (value) {
                        Marca.text = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Marca del Vehículo Vacio");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.discount),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "${carro.nombre_marca}",
                        hintStyle: TextStyle(
                          fontFamily: 'biko',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
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
                      controller: Precio,
                      onSaved: (value) {
                        Precio.text = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Precio del Vehículo Vacio");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.payment),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "${carro.precio}",
                        hintStyle: TextStyle(
                          fontFamily: 'biko',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
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
                      controller: Kilometraje,
                      onSaved: (value) {
                        Kilometraje.text = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Kilometraje del Vehículo Vacio");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.av_timer),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "${carro.kilometraje}",
                        hintStyle: TextStyle(
                          fontFamily: 'biko',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
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
                            "Cambiar transmisión",
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
                              value: trans_ligth,
                              onChanged: (state) {
                                setState(() {
                                  trans_ligth = !trans_ligth;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (trans_ligth == true) ...[
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          child: Text(
                            'Transmisión',
                            style: TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 15),
                            textAlign: TextAlign.left,
                          )),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black.withOpacity(.4)),
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: DropdownButton<String>(
                          value: transmicion,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(
                              fontFamily: 'biko',
                              color: Colors.black,
                              fontSize: 16),
                          onChanged: (String? newValue) {
                            setState(() {
                              transmicion = newValue!;
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
                  SizedBox(height: 10),
                ],
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
                            "Cambiar el tipo de combustible",
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
                              value: gas_ligth,
                              onChanged: (state) {
                                setState(() {
                                  gas_ligth = !gas_ligth;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (gas_ligth == true) ...[
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
                            border:
                                Border.all(color: Colors.black.withOpacity(.4)),
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
                  SizedBox(height: 10),
                ],
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
                            "Cambiar la carrocería",
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
                              value: carr_ligth,
                              onChanged: (state) {
                                setState(() {
                                  carr_ligth = !carr_ligth;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (carr_ligth == true) ...[
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
                            border:
                                Border.all(color: Colors.black.withOpacity(.4)),
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
                            'Sedán',
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
                  SizedBox(height: 10),
                ],
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
                              'Seleccionar el año',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontFamily: 'biko', fontSize: 16),
                            ),
                          )),
                    ),
                    Expanded(
                        child: Text(
                      ano_ahora == true ? "${ano}" : "${carro.ano_modelo}",
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                SizedBox(height: 10),
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
                            "Cambiar las condiciones",
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
                              value: estado_ligth,
                              onChanged: (state) {
                                setState(() {
                                  estado_ligth = !estado_ligth;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (estado_ligth == true) ...[
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          child: Text(
                            'Condiciones',
                            style: TextStyle(
                                fontFamily: 'biko',
                                color: Colors.black,
                                fontSize: 15),
                            textAlign: TextAlign.left,
                          )),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black.withOpacity(.4)),
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
                  SizedBox(height: 10),
                ],
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
                            "Cambiar la tracción",
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
                              value: tracc_ligth,
                              onChanged: (state) {
                                setState(() {
                                  tracc_ligth = !tracc_ligth;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (tracc_ligth == true) ...[
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
                            border:
                                Border.all(color: Colors.black.withOpacity(.4)),
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
                  SizedBox(height: 10),
                ],
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
                        prefixIcon: Icon(Icons.numbers),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "${carro.numero_puertas}",
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
                        hintText: "${carro.color}",
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
                Container(
                    width: double.infinity,
                    child: Text(
                      "Fecha de adquisición",
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 15),
                      textAlign: TextAlign.left,
                    )),
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
                              'Seleccionar la fecha',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontFamily: 'biko', fontSize: 16),
                            ),
                          )),
                    ),
                    Expanded(
                        child: Text(
                      Fecha_ahora == true
                          ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
                          : "${carro.fecha_compra}",
                      style: TextStyle(
                          fontFamily: 'biko',
                          color: Colors.black,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                if (carro.garantia != null) ...[
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          child: Text(
                            "Tiempo de garantía",
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
                        controller: _tiempogarantia,
                        onSaved: (value) {
                          _tiempogarantia.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Garantía Vacia");
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.date_range),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "${carro.garantia}",
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
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UpdateCarrosDetails() async {
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
              Expanded(
                flex: 2,
                child: Icon(
                  Icons.update,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 8,
                child: Text('La información ha sido actualizada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'biko',
                      fontSize: 20,
                      color: Colors.white,
                    )),
              )
            ],
          )),
      backgroundColor: RED_CAR,
    ));
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CarroModel carroModel = CarroModel();
    Navigator.pop(context);
    carroModel.fotos = carro.fotos;
    carroModel.uid = carro.uid;
    carroModel.uid_vendedor = carro.uid_vendedor;
    carroModel.guia_mantenimiento = carro.guia_mantenimiento;

    if (carro.garantia != null) {
      if (_tiempogarantia.text == "") {
        carroModel.garantia = carro.garantia;
      } else {
        carroModel.garantia = _tiempogarantia.text;
      }
    }

    if (Nombre.text == "") {
      carroModel.nombre_carro = carro.nombre_carro;
    } else {
      carroModel.nombre_carro = Nombre.text;
      await firebaseFirestore
          .collection('users')
          .doc(carro.uid_vendedor)
          .collection('Vehículos')
          .doc(carro.uid)
          .update({
        'nombre_carro': Nombre.text,
      });
    }

    if (Marca.text == "") {
      carroModel.nombre_marca = carro.nombre_marca;
    } else {
      carroModel.nombre_marca = Marca.text;
    }
    if (Precio.text == "") {
      carroModel.precio = carro.precio;
    } else {
      carroModel.precio = int.parse(Precio.text);
    }
    if (Kilometraje.text == "") {
      carroModel.kilometraje = carro.kilometraje;
    } else {
      carroModel.kilometraje = Kilometraje.text;
    }
    if (gas_ligth == true) {
      carroModel.tipo_gasolina = Gasolina;
    } else {
      carroModel.tipo_gasolina = carro.tipo_gasolina;
    }
    if (carr_ligth == true) {
      carroModel.carroceria = carroceria;
    } else {
      carroModel.carroceria = carro.carroceria;
    }

    if (trans_ligth == true) {
      carroModel.transmicion = transmicion;
    } else {
      carroModel.transmicion = carro.transmicion;
    }
    if (ano_ahora == true) {
      carroModel.ano_modelo = ano;
    } else {
      carroModel.ano_modelo = carro.ano_modelo;
    }
    if (_colorController.text == "") {
      carroModel.color = carro.color;
    } else {
      carroModel.color = _colorController.text;
    }
    if (_numero_puertasController.text == "") {
      carroModel.numero_puertas = carro.numero_puertas;
    } else {
      carroModel.numero_puertas = _numero_puertasController.text;
    }

    if (tracc_ligth == true) {
      carroModel.traccion = traccion;
    } else {
      carroModel.traccion = carro.traccion;
    }

    if (Fecha_ahora == true) {
      carroModel.fecha_compra =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    } else {
      carroModel.fecha_compra = carro.fecha_compra;
    }

    if (estado_ligth == true) {
      carroModel.estado_porcentaje = estado;
    } else {
      carroModel.estado_porcentaje = carro.estado_porcentaje;
    }

    if (carro.tipo_agregado == 1) {
      if (_porcentaje_descuentoController.text == "") {
        carroModel.porcentaje_descuento = carro.porcentaje_descuento;
      } else {
        carroModel.porcentaje_descuento =
            int.parse(_porcentaje_descuentoController.text);
      }
    } else {
      if (carro.tipo_agregado == 2) {
      } else {
        carroModel.porcentaje_falla = 4;
        if (_detalles_compraController.text == "") {
          carroModel.detalles = carro.detalles;
        } else {
          carroModel.detalles = _detalles_compraController.text;
        }

        if (_detalle_prinController.text == "") {
          carroModel.detalle_principal = carro.detalle_principal;
        } else {
          carroModel.detalle_principal = _detalle_prinController.text;
        }
      }
    }
    carroModel.tipo_agregado = carro.tipo_agregado;

    await firebaseFirestore
        .collection('carros')
        .doc(carro.uid)
        .update(carroModel.toMap());
  }
}
