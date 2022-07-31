// ignore_for_file: deprecated_member_use
import 'package:car_finder/Authenticator.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement build
    Firebase.initializeApp();
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
      alignment: Alignment(0, 0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/logob.png', width: 230, height: 250),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  '¡Sea Bienvenido!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: ax,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Nuevas oportunidades nos esperan...',
                  textAlign: TextAlign.left,
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
              SizedBox(height: 25),

              //sign-in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
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
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 192, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Icon(
                              Icons.login,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              'Iniciar sesión',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: ax,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              SizedBox(height: 10),

              //Google Button? xd
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () async {
                    User? user =
                        await Authenticator.iniciarSesion(context: context);
                    print(user?.displayName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
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
                        Text(
                          'Entrar con Google',
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
              ),
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
      ),
    ));
  }
}
