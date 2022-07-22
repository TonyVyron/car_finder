import 'package:car_finder/services/firebase_auth_methods.dart';
//import 'package:car_finder/widgets/widgets.dart';
import 'package:car_finder/screens/login_email_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_email_password_screen.dart';

var ax = 'biko';
bool _passwordVisible = true;

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
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
                  controller: emailController,
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
                      onPressed: () => emailController.clear(),
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
                  controller: passwordController,
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
              //sign-in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    signUpUser();
                    Navigator.pushNamed(context, '/home');
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, EmailPasswordLogin.routeName);
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
            ],
          ),
        ),
      ),
    ));
  }
}
