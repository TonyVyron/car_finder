//import 'dart:html';
import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/screens/inicio_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return home();
        } else {
          return InicioScreen();
        }
      },
    ));
  }
}
