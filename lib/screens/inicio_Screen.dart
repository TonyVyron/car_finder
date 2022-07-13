// ignore_for_file: deprecated_member_use

import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextTitulo(text: 'Inicio')),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              child: Text(
                'Aqui va el login y la parte de Registro',
                style: TextStyle(
                  fontFamily: 'biko',
                  fontSize: LABEL_SIZE,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => home(),
                  ),
                );
              },
              child: TextParrafo(
                text: 'IR AL INICIO'.toTitleCase(),
                style: TextStyle(
                  fontFamily: 'biko',
                  fontSize: LABEL_SIZE,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
