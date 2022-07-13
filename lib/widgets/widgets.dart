import 'package:flutter/material.dart';

final Color RED_CAR = Color.fromARGB(255, 192, 0, 0);
Color LABEL_COLOR = Colors.white;
double LABEL_SIZE = 18;
double LABEL_CAJA = 15;

TextTitulo({String? text, TextStyle? style, bool islighted = false}) => Padding(
    padding: EdgeInsets.all(10),
    child: Text(
      text ?? "Texto",
      style: style ??
          TextStyle(
            fontFamily: 'biko',
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: islighted ? Colors.black : Colors.white,
          ),
      textAlign: TextAlign.center,
    ));

TextParrafo(
    {String? text, TextStyle? style, IconData? icon, bool islighted = false}) {
  return Padding(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      child: icon == null
          ? Text(
              text ?? "Texto",
              style: style ??
                  TextStyle(
                    fontFamily: 'biko',
                    fontSize: LABEL_SIZE,
                    color: islighted ? Colors.black : Colors.white,
                  ),
              textAlign: TextAlign.justify,
            )
          : Row(children: [
              Container(
                margin: EdgeInsets.only(right: 3),
                child: Icon(
                  icon,
                  color: islighted ? Colors.black : Colors.black,
                  size: LABEL_SIZE * 1.5,
                ),
              ),
              Text(
                text ?? "Texto",
                style: style ??
                    TextStyle(
                      fontFamily: 'biko',
                      fontSize: LABEL_SIZE,
                      color: islighted ? Colors.black : Colors.white,
                    ),
              )
            ]));
}

TextValue({String? text, TextStyle? style, bool islighted = false}) => Padding(
    padding: EdgeInsets.only(left: 20, bottom: 5, top: 5),
    child: Text(
      text ?? "Texto",
      style: style ??
          TextStyle(
            fontFamily: 'biko',
            color:
                islighted ? Colors.black : Colors.white, //color ?? LABEL_COLOR,
            fontSize: LABEL_SIZE,
            //fontWeight: FontWeight.bold
          ),
    ));

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
