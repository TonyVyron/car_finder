import 'package:car_finder/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
        ),
      ),
    );
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
                return ("Por favor ingresa Tu Email");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Por favor verifica Tu Email");
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
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPrimary: Colors.white,
            shadowColor: Colors.black,
            elevation: 15,
          ),
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
    final buttonRegister = Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: Text(
              '¿Aún no eres usuario? ',
              style: TextStyle(
                fontFamily: ax,
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPrimary: Colors.white,
                primary: Colors.black,
                shadowColor: Colors.black,
                elevation: 15,
              ),
              onPressed: widget.showRegisterPage,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  "Regístrate",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: ax,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
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
              SizedBox(height: 20),
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
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
                            'Inicio de sesión exitoso',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'biko', fontSize: 22),
                          ),
                        );
                      }),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Correo no válido";

            break;
          case "wrong-password":
            errorMessage = "Contraseña incorrecta";
            break;
          case "user-not-found":
            errorMessage = "Este usuario no ha sido registrado";
            break;
          case "user-disabled":
            errorMessage = "Usuario desabilitado";
            break;
          case "too-many-requests":
            errorMessage = "Por favor intente más tarde";
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
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.message,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text(errorMessage!,
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
