import 'package:car_finder/Authenticator.dart';
import 'package:car_finder/screens/registercliente.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';

import 'forgot_pw_page.dart';

var ax = 'biko';
bool _passwordVisible = true;

class Inicio extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const Inicio({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/logob.png', width: 230, height: 250),
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
            SizedBox(height: 15),
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

            SizedBox(height: 20),
            //logo xd

            //username
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 192, 0, 0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Correo Electrónico',
                  hintStyle: TextStyle(
                    fontFamily: ax,
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () => _emailController.clear(),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 20),

            //passwd Textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                obscureText: _passwordVisible,
                controller: _passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 192, 0, 0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Contraseña',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  hintStyle: TextStyle(
                    fontFamily: ax,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),

            SizedBox(height: 15),

            //Forgot passwd
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
            ),

            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(RED_CAR),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))),
                  onPressed: () {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      signIn();
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: RED_CAR,
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
                                  Icons.error,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Text("Paramateros Incompletos",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'biko',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ))
                              ],
                            )),
                      ));
                    }
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
            ),

            //sign-in button

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))),
                  onPressed: () async {
                    User? user =
                        await Authenticator.iniciarSesion(context: context);
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
            ),

            //Google Button? xd

            SizedBox(height: 20),

            //not a member? Register now
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¿Aún no eres usuario? ',
                    style: TextStyle(
                      fontFamily: ax,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      'Regístrate',
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
            SizedBox(height: 15),
          ],
        ),
      ),
    );
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
                fontFamily: ax,
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
              style: TextStyle(fontFamily: ax, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
