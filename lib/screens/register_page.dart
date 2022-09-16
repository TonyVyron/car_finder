import 'dart:async';
import 'dart:io';
import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_place/google_place.dart';

var ax = 'biko';
bool _passwordVisible = true;

class RegisterPage extends StatefulWidget {
  final VoidCallback showInicio;
  const RegisterPage({
    Key? key,
    required this.showInicio,
    String? tipo,
  }) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DetailsResult? startPosition;
  late FocusNode startFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

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

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  final _formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _numeroController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _directionController = TextEditingController();
  final _ageController = TextEditingController();
  var latitud = "";
  var longitud = "";
  final _NombreLocal = TextEditingController();

  File? _image;
  String? UrlImage;
  bool islighted = true;
  final imagePicker = ImagePicker();

  Future imagepickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showsnackbar(
            'No hay imagen',
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
            'No hay imagen',
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

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailfield = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
            autofocus: false,
            style: TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Por favor, ingresa tu correo");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Por favor, verifica tu correo");
              }
              return null;
            },
            onSaved: (value) {
              _emailController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: islighted == true ? "Correo" : "Correo de contacto",
              hintStyle: TextStyle(
                fontFamily: ax,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )));

    final namefield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
        controller: _nameController,
        onSaved: (value) {
          _nameController.text = value!;
        },
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Nombre Vacio");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingrese un Minimo de 3 Caracteres)");
          }
          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: islighted == true ? "Nombre(s)" : "Nombre(s) del encargado",
          hintStyle: TextStyle(
            fontFamily: ax,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final localfield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        controller: _NombreLocal,
        onSaved: (value) {
          _NombreLocal.text = value!;
        },
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Nombre de la tienda");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingrese un Minimo de 3 Caracteres)");
          }
          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.store_mall_directory),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nombre de la tienda",
          hintStyle: TextStyle(
            fontFamily: ax,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final lastnamefield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
        controller: _lastNameController,
        onSaved: (value) {
          _lastNameController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Apellido Vacio");
          }
          return null;
        },
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.man),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: islighted == true ? "Apellidos" : "Apellidos del encargado",
          hintStyle: TextStyle(
            fontFamily: ax,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final agefield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
        controller: _ageController,
        onSaved: (value) {
          _ageController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Edad Vacio");
          }

          return null;
        },
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.numbers),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: islighted == true ? "Edad" : "Edad del encargado",
          hintStyle: TextStyle(
            fontFamily: ax,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final numerofield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        controller: _numeroController,
        onSaved: (value) {
          _numeroController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Telefono Vacio");
          }
          return null;
        },
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText:
              islighted == true ? "Número telefónico" : "Número de contacto",
          hintStyle: TextStyle(
            fontFamily: ax,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final direccionfield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          TextFormField(
            autofocus: false,
            controller: _directionController,
            focusNode: startFocusNode,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
            onSaved: (value) {
              _directionController.text = value!;
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
              suffixIcon: _directionController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          predictions = [];
                          _directionController.clear();
                        });
                      },
                      icon: Icon(Icons.clear_outlined),
                    )
                  : null,
              prefixIcon: Icon(Icons.place),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText:
                  islighted == true ? "Dirección" : "Dirección de la tienda",
              hintStyle: TextStyle(
                fontFamily: ax,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
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

                    final details = await googlePlace.details.get(placeId);
                    if (details != null && details.result != null && mounted) {
                      if (startFocusNode.hasFocus) {
                        setState(() {
                          startPosition = details.result;
                          _directionController.text = details.result!.name!;
                          latitud = details.result!.geometry!.location!.lat
                              .toString();
                          longitud = details.result!.geometry!.location!.lng
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
    );
    final passfield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        controller: _passwordController,
        obscureText: _passwordVisible,
        onSaved: (value) {
          _passwordController.text = value!;
        },
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Contraseña Requerida");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingresa un Minimo de 6 Caracteres");
          }
        },
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contraseña",
          hintStyle: TextStyle(
            fontFamily: ax,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final confirmpassfield = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        controller: _confirmPasswordController,
        obscureText: _passwordVisible,
        onSaved: (value) {
          _confirmPasswordController.text = value!;
        },
        validator: (value) {
          if (_confirmPasswordController.text != _passwordController.text) {
            return "Contraseñas Distintas";
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirmar su contraseña",
          hintStyle: TextStyle(
            fontFamily: ax,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
    final buttonregis = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () {
          if (_image != null) {
            SignUp2(_emailController.text, _passwordController.text);
            setState(() {
              FirebaseAuth.instance.signOut();
            });
          } else {
            showsnackbar(
                'Imagen no seleccionada',
                Duration(milliseconds: 600),
                Icon(
                  Icons.close,
                  size: 25,
                  color: Colors.white,
                ));
          }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 192, 0, 0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.save,
                    size: 30,
                    color: Colors.white,
                  )),
              Text(
                'Terminar',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: ax,
                    fontSize: 20),
              ),
            ],
          )),
        ),
      ),
    );

    final cliente_Reg = Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logob.png', width: 210, height: 200),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              '¡Nos alegra recibirlo!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: ax,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Regístrese a continuación con sus datos',
              style: TextStyle(
                fontSize: 20,
                fontFamily: ax,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: RED_CAR,
                  borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              alignment: Alignment(0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Registrarse como cliente',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: ax,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Switch(
                        activeColor: Colors.white,
                        value: islighted,
                        onChanged: (state) {
                          setState(() {
                            islighted = !islighted;
                          });
                        }),
                  ),
                ],
              )),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1),
                color: Colors.white),
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Escoga su foto de perfil',
              style: TextStyle(
                fontSize: 21,
                fontFamily: ax,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      contentPadding: EdgeInsets.all(0),
                      content: SingleChildScrollView(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              imagepickerCamara();
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "Tomar una foto",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'biko',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          InkWell(
                            onTap: () {
                              imagepickerMethod();
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "Elegir una desde galería",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'biko',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Icon(
                                        Icons.photo_album_sharp,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Divider(
                            thickness: 2,
                          ),
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
                          SizedBox(height: 20),
                        ],
                      )),
                    );
                  });
            },
            child: Container(
              height: 160,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(width: .5),
                image: DecorationImage(
                    image: _image == null
                        ? Image.asset('assets/Imagen1.png').image
                        : Image.file(_image!).image,
                    fit: BoxFit.fill),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 10),
          emailfield,
          SizedBox(height: 10),
          namefield,
          SizedBox(height: 10),
          lastnamefield,
          SizedBox(height: 10),
          agefield,
          SizedBox(height: 10),
          numerofield,
          SizedBox(height: 10),
          direccionfield,
          SizedBox(height: 10),
          passfield,
          SizedBox(height: 10),
          confirmpassfield,
          SizedBox(height: 10),
          buttonregis,
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '¿Ya estás registrado?',
                  style: TextStyle(
                    fontFamily: ax,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: widget.showInicio,
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: ax,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );

    final Vendedor_Reg = Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logob.png', width: 210, height: 200),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              '¡Nos alegra recibirlo!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: ax,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Regístrese a continuación con sus datos',
              style: TextStyle(
                fontSize: 20,
                fontFamily: ax,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: RED_CAR,
                  borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              alignment: Alignment(0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Registrarse como vendedor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: ax,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Switch(
                        activeColor: Colors.white,
                        value: islighted,
                        onChanged: (state) {
                          setState(() {
                            islighted = !islighted;
                          });
                        }),
                  ),
                ],
              )),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1),
                color: Colors.white),
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Suba el logo de tienda',
              style: TextStyle(
                fontSize: 21,
                fontFamily: ax,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      contentPadding: EdgeInsets.all(0),
                      content: SingleChildScrollView(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              imagepickerCamara();
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "Tomar una foto",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'biko',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          InkWell(
                            onTap: () {
                              imagepickerMethod();
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "Elegir una desde galería",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'biko',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Icon(
                                        Icons.photo_album_sharp,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Divider(
                            thickness: 2,
                          ),
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
                          SizedBox(height: 20),
                        ],
                      )),
                    );
                  });
            },
            child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 80,
                child: Container(
                  height: 160,
                  width: 158,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: _image == null
                            ? Image.network(
                                    'https://us.123rf.com/450wm/myvector/myvector1201/myvector120100432/12121873-ilustraci%C3%B3n-vectorial-de-un-solo-icono-aislado-venta-de-coches.jpg?ver=6')
                                .image
                            : Image.file(_image!).image,
                        fit: BoxFit.fill),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                )),
          ),
          SizedBox(height: 10),
          localfield,
          SizedBox(height: 10),
          emailfield,
          SizedBox(height: 10),
          namefield,
          SizedBox(height: 10),
          lastnamefield,
          SizedBox(height: 10),
          agefield,
          SizedBox(height: 10),
          numerofield,
          SizedBox(height: 10),
          direccionfield,
          SizedBox(height: 10),
          passfield,
          SizedBox(height: 10),
          confirmpassfield,
          SizedBox(height: 10),
          buttonregis,
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '¿Ya estás registrado?',
                  style: TextStyle(
                    fontFamily: ax,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: widget.showInicio,
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: ax,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
      alignment: Alignment(0, 0),
      child: SafeArea(
        child: SingleChildScrollView(
            child: islighted == true ? cliente_Reg : Vendedor_Reg),
      ),
    ));
  }

  void SignUp2(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: e!.message,
            backgroundColor: RED_CAR,
            textColor: Colors.white,
            fontSize: 16);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    final PostId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${user?.uid}/images")
        .child('Foto_Perfil');
    await ref.putFile(_image!);
    UrlImage = await ref.getDownloadURL();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.Apellidos = _lastNameController.text;
    userModel.Nombre = _nameController.text;
    userModel.Edad = _ageController.text;
    userModel.status = islighted == true ? "Cliente" : "Vendedor";
    userModel.Telefono = _numeroController.text;
    userModel.Direcc = _directionController.text;
    userModel.Cor_lat = double.parse(latitud);
    userModel.Cor_long = double.parse(longitud);

    if (islighted == true) {
      userModel.Favoritos = ["Carro"];
    } else {}

    userModel.foto = UrlImage;
    if (islighted == false) {
      userModel.NombreLocal = _NombreLocal.text;
      await firebaseFirestore
          .collection('estrellas')
          .doc(user.uid)
          .set({'raiting': 5.0, 'uid_vendedor': user.uid});
    }

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(
        msg: "Cuenta registrada",
        backgroundColor: RED_CAR,
        textColor: Colors.white,
        fontSize: 16);
  }
}
