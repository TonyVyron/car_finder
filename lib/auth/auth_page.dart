//import 'dart:html';
import 'package:car_finder/screens/inicio_Screen.dart';
import 'package:car_finder/screens/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially, show the login page
  bool showInicio = true;

  void toggleScreens() {
    setState(() {
      showInicio = !showInicio;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showInicio) {
      return Inicio(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showInicio: toggleScreens);
    }
  }
}
