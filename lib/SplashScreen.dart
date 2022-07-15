import 'package:animate_do/animate_do.dart';
import 'package:car_finder/auth/main_page.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class splashsc extends StatefulWidget {
  const splashsc({Key? key}) : super(key: key);

  @override
  State<splashsc> createState() => _splashscState();
}

class _splashscState extends State<splashsc> {
  @override
  void initState() {
    Future.delayed(
        Duration(milliseconds: 3000),
        (() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomIn(
                  child: Image.asset('assets/logo2p.png',
                      width: 290, height: 300)),
              ElasticInUp(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                      child: Transform.scale(
                    scale: 1.6,
                    child: CircularProgressIndicator(
                      color: RED_CAR,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
