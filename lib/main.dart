import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 144, 12, 48),
          title: Text(
            'Car Finder',
            style: TextStyle(fontFamily: 'biko', fontWeight: FontWeight.w500),
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop p',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'biko',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
