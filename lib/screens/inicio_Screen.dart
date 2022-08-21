import 'dart:math';
import 'package:car_finder/Authenticator.dart';
import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/screens/logintipo.dart';
import 'package:car_finder/screens/register_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:car_finder/screens/registercliente.dart';
import 'package:car_finder/screens/registervendedor.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:page_indicator/page_indicator.dart';

import 'forgot_pw_page.dart';

class Inicio extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const Inicio({
    Key? key,
    required this.showRegisterPage,
    String? tipo,
  }) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final _formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  var ax = 'biko';

  bool _passwordVisible = true;

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
            alignment: Alignment(0, 0),
            child: PageIndicatorContainer(
              child: PageView(
                children: [
                  _DescriptionPage(
                      title: 'Encuentra opciones de acuerdo a tu medida',
                      text:
                          'No importa el número de puertas, de seguro encuentras la opción que más se ajuste a tu presupuesto y gustos',
                      imagePath: 'assets/Page1.png'),
                  _DescriptionPage(
                      title: 'Seguridad',
                      text:
                          'Nos aseguramos de que nuestros vendedores cuenten con los documentos necesarios para hacer de forma práctica y confiable el trato con usted',
                      imagePath: 'assets/Page2.png'),
                  _DescriptionPage(
                      title: '¡Estas y más marcas!',
                      text:
                          'La más amplia variedad que tendrá al alcance de un toque',
                      imagePath: 'assets/Page3.png'),
                  Container(
                    child: _LoginPage(),
                  ),
                ],
              ),
              length: 4,
              align: IndicatorAlign.bottom,
              indicatorSpace: 10,
              indicatorColor: RED_CAR,
            )));
  }

  Widget _LoginPage() {
    final emailfield = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
            autofocus: false,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Porfavor Ingresa Tu Email");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Porfavor Verifica Tu Email");
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
              hintText: "Email",
              hintStyle: TextStyle(
                fontFamily: ax,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )));
    final forgotpass = Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ForgotPasswordPage();
              }));
            },
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: ax,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
    final passfield = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
            autofocus: false,
            obscureText: _passwordVisible,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              RegExp regex = new RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ("Contraseña Requerida");
              }
              if (!regex.hasMatch(value)) {
                return ("Ingresa un Minimo de 6 Caracteres");
              }
            },
            onSaved: (value) {
              _passwordController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Password",
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
            )));

    final butinicio = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(RED_CAR),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ))),
          onPressed: () {
            signIn2(_emailController.text, _passwordController.text);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                        width: double.infinity,
                        child: Icon(
                          Icons.login,
                          size: 25,
                        ))),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Iniciar Sesión',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'biko',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
    final entrargoogle = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ))),
          onPressed: () async {
            User? user = await Authenticator.iniciarSesion(context: context);
            print(user?.displayName);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      child: CircleAvatar(
                        radius: 14,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(
                                        'https://e7.pngegg.com/pngimages/337/722/png-clipart-google-search-google-account-google-s-google-play-google-company-text.png')
                                    .image,
                                fit: BoxFit.cover),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Entrar con Google',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: ax,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
    final buttonRegister = Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '¿Aún no eres usuario? ',
            style: TextStyle(
              fontFamily: ax,
              fontSize: 16,
            ),
          ),
          SpeedDial(
            label: Text(
              "Registro",
              style: TextStyle(
                color: Colors.white,
                fontFamily: ax,
                fontSize: 15,
              ),
            ),
            visible: true,
            curve: Curves.bounceIn,
            children: [
              // FAB 1
              SpeedDialChild(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  backgroundColor: RED_CAR,
                  onTap: widget.showRegisterPage,
                  label: 'Cliente',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: ax,
                    fontSize: 18,
                  ),
                  labelBackgroundColor: RED_CAR),
              // FAB 2
              SpeedDialChild(
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  backgroundColor: RED_CAR,
                  onTap: () {},
                  label: 'Vendedor',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: ax,
                    fontSize: 18,
                  ),
                  labelBackgroundColor: RED_CAR)
            ],
          )
        ],
      ),
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logob.png', width: 210, height: 220),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  '¡Sea Bienvenido!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: ax,
                    fontSize: 35,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Nuevas oportunidades nos esperan...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: ax,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 15),
              emailfield,
              SizedBox(height: 15),
              passfield,
              SizedBox(height: 15),
              forgotpass,
              SizedBox(height: 15),
              butinicio,
              SizedBox(height: 15),
              entrargoogle,
              SizedBox(height: 15),
              buttonRegister,
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  void signIn2(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => home())),
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        const displayTime = Duration(seconds: 2);
                        return AlertDialog(
                          title: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Image(
                              image: AssetImage("assets/logob.png"),
                              width: 220,
                              height: 220,
                            ),
                          ),
                          content: Text(
                            'Inicio de Sesión Completado',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'biko', fontSize: 22),
                          ),
                        );
                      }),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Email Invalidado";

            break;
          case "wrong-password":
            errorMessage = "Contraseña Incorrecta";
            break;
          case "user-not-found":
            errorMessage = "Usuario Sin Registrar";
            break;
          case "user-disabled":
            errorMessage = "Usuario desabilitado";
            break;
          case "too-many-requests":
            errorMessage = "Muchas Solicitudes";
            break;
          case "operation-not-allowed":
            errorMessage = "Inicio de Sesión no Habilitado.";
            break;
          default:
            errorMessage = "Error indefinido";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          content: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.message,
                    size: 25,
                    color: Colors.white,
                  ),
                  Text(errorMessage!,
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

        print(error.code);
      }
    }
  }
}

class _DescriptionPage extends StatelessWidget {
  final String title;
  final String text;
  final String imagePath;

  const _DescriptionPage(
      {Key? key,
      required this.title,
      required this.text,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 250,
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'biko',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(fontFamily: 'biko', fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
