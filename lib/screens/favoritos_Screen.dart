import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Favoritos extends StatelessWidget {
  const Favoritos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextParrafo(
        text: 'Historial',
        style: TextStyle(
            fontFamily: 'biko',
            fontWeight: FontWeight.bold,
            fontSize: LABEL_SIZE,
            color: Colors.black),
      ),
    );
  }
}
