import 'package:car_finder/screens/inicio_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

var ax = 'biko';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.white,
                child: Image(
                  image: AssetImage("assets/logob.png"),
                  width: 220,
                  height: 220,
                ),
              ),
              content: Text(
                '¡El link ha sido enviado! Por favor, revise su correo. \n(De no encontrarlo revise la bandeja de spam)',
                textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: 'biko', fontSize: 17),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
                      'Reestablecer contraseña',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: ax,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Escriba su correo electrónico a continuación y se le enviará un link para reestablecer su contraseña',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: ax,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  //logo xd

                  //email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController,
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
                          onPressed: () {}, //_emailController.clear(),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //send button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: passwordReset,
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
                                  Icons.send_rounded,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            Text(
                              'Enviar',
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 5,
          child: IconButton(
              iconSize: 50,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_circle_left,
                color: Colors.white,
              )),
        ),
      ],
    ));
  }
}
