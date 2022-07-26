//import 'dart:html';
import 'package:car_finder/screens/login_email_password_screen.dart';
import 'package:car_finder/screens/phone_screen.dart';
import 'package:car_finder/screens/signup_email_password_screen.dart';
import 'package:car_finder/services/firebase_auth_methods.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

var ax = 'biko';

class InicioScreen extends StatelessWidget {
  static Widget create(BuildContext context) => InicioScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
      child: _InicioPager(),
    ));
  }
}

class _InicioPager extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return PageIndicatorContainer(
      child: PageView(
        children: [
          _DescriptionPage(
              title: 'Encuentra opciones de acuerdo a tu medida',
              text:
                  'No importa el número de puertas, de seguro encuentras la opción que más se ajuste a tu presupuesto y gustos',
              imagePath: 'assets/Page1.png'),
          _DescriptionPage(
              title: 'Seguridad',
              text:
                  'Nos aseguramos de que nuestros vendedores cuenten con los documentos necesarios para hacer de forma práctica y confiable el trato con usted',
              imagePath: 'assets/Page2.png'),
          _DescriptionPage(
              title: '¡Estas y más marcas!',
              text: 'La más amplia variedad que tendrá al alcance de un toque',
              imagePath: 'assets/Page3.png'),
          Container(
            child: _LoginPage(),
          ),
        ],
      ),
      length: 4,
      align: IndicatorAlign.bottom,
      indicatorSpace: 12,
      indicatorColor: RED_CAR,
    );
  }
}

class _DescriptionPage extends StatelessWidget {
  final String title;
  final String text;
  final String imagePath;

  const _DescriptionPage(
      {Key? key,
      required this.title,
      required this.text,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 250,
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: ax,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(fontFamily: ax, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/logob.png', width: 230, height: 250),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  '¡Sea Bienvenido!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: ax,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Nuevas oportunidades nos esperan...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: ax,
                    fontSize: 20,
                  ),
                ),
              ),

              SizedBox(height: 20),
              //logo xd

              //sign-in email button
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
                              Icons.mail_outline_outlined,
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
                              'Entrar con correo',
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
              SizedBox(height: 10),

              //sign-in phone button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PhoneScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Icon(
                              Icons.phone_android,
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
                              'Entrar con número',
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
              SizedBox(height: 10),

              //Google Button? xd
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInWithGoogle(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.network(
                                          'https://e7.pngegg.com/pngimages/337/722/png-clipart-google-search-google-account-google-s-google-play-google-company-text.png')
                                      .image,
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          'Entrar con Google',
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

              //sign-in Facebook button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInWithFacebook(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Icon(
                              Icons.facebook,
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
                              'Entrar con Facebook',
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
              SizedBox(height: 10),

              //sign-in Anononimously button
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: GestureDetector(
              //     onTap: () {
              //       context
              //           .read<FirebaseAuthMethods>()
              //           .signInAnonymously(context);
              //     },
              //     child: Container(
              //       padding: EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Center(
              //           child: Row(
              //         children: [
              //           Expanded(
              //             flex: 2,
              //             child: Container(
              //               child: Icon(
              //                 Icons.supervised_user_circle,
              //                 color: Colors.white,
              //                 size: 25,
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             flex: 5,
              //             child: Container(
              //               width: double.infinity,
              //               child: Text(
              //                 'Entrar anónimamente',
              //                 textAlign: TextAlign.left,
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w500,
              //                     fontFamily: ax,
              //                     fontSize: 20),
              //               ),
              //             ),
              //           ),
              //         ],
              //       )),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),

              //not a member? Register now
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '¿Aún no eres usuario? ',
                      style: TextStyle(
                        fontFamily: ax,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, EmailPasswordSignup.routeName);
                      },
                      child: Text(
                        'Regístrate',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: ax,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
