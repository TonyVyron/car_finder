import 'package:car_finder/Authenticator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var ax = 'biko';

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
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo2p.png', width: 200, height: 250),
                  SizedBox(height: 10),
                  Text(
                    '¡Nos alegra recibirlo!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ax,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Regístrese a continuación con sus datos',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: ax,
                    ),
                  ),
                  SizedBox(height: 25),
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
                      obscureText: true,
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
                      obscureText: true,
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
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 192, 0, 0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Terminar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: ax,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //not a member? Register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya estás registrado? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ax,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showInicio,
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: ax,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
