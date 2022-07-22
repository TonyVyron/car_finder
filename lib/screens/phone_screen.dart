import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var ax = 'biko';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
        alignment: Alignment(0, 0),
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
                    'Ingrese su número de teléfono',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: ax,
                      fontSize: 20,
                    ),
                  ),
                ),

                SizedBox(height: 20),
                //logo xd

                //username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: phoneController,
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
                      hintText: 'Introduzca el código de país y su número',
                      hintStyle: TextStyle(
                        fontFamily: ax,
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () => phoneController.clear(),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 25),

                //sign-in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<FirebaseAuthMethods>()
                          .phoneSignIn(context, phoneController.text);
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
                                Icons.done,
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
                                'Enviar OTP',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
