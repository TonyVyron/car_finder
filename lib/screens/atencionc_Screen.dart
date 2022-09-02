import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Atencion_Clientes extends StatelessWidget {
  const Atencion_Clientes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextParrafo(
        text: 'Atención a clientes',
        style: TextStyle(
            fontFamily: 'biko',
            fontWeight: FontWeight.bold,
            fontSize: LABEL_SIZE,
            color: Colors.black),
      ),
    );
  }
}
