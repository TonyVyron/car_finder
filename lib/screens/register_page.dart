import 'package:car_finder/Authenticator.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var ax = 'biko';
bool _passwordVisible = true;
bool _passwordVisible2 = true;

class RegisterPage extends StatefulWidget {
  final VoidCallback showInicio;
  const RegisterPage({Key? key, required this.showInicio}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {}
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
      alignment: Alignment(0, 0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logob.png', width: 250, height: 240),

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
              SizedBox(height: 5),
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
              SizedBox(height: 15),
              //logo xd

              //username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
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
                    hintStyle: TextStyle(
                      fontFamily: ax,
                    ),
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
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 20),

              //confirm passwd textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: _passwordVisible,
                  controller: _confirmPasswordController,
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
                    hintText: 'Confirme la contraseña',
                    hintStyle: TextStyle(
                      fontFamily: ax,
                    ),
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
                    if (passwordConfirmed() == true &&
                        _emailController.text.isNotEmpty) {
                      signUp();
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
                                Text("Parametros Incorrectos",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.app_registration,
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
                      '¿Ya estás registrado? ',
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
        ),
      ),
    ));
  }
}
