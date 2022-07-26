import 'package:animate_do/animate_do.dart';
import 'package:car_finder/screens/inicio_Screen.dart';
import 'package:car_finder/screens/perfil_Screen.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_finder/firebase_options.dart';
import 'package:car_finder/screens/home_screen.dart';
import 'package:car_finder/screens/login_email_password_screen.dart';
import 'package:car_finder/screens/phone_screen.dart';
import 'package:car_finder/screens/signup_email_password_screen.dart';
import 'package:car_finder/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase Auth Demo',
        theme: ThemeData(
          primaryColor: buildMaterialColor(Color.fromARGB(255, 192, 0, 0)),
          primarySwatch: buildMaterialColor(Color.fromARGB(255, 192, 0, 0)),
          brightness: Brightness.light,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.black),
        ),
        home: const AuthWrapper(),
        routes: {
          EmailPasswordSignup.routeName: (context) =>
              const EmailPasswordSignup(),
          EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
          PhoneScreen.routeName: (context) => const PhoneScreen(),
          home.routeName: (context) => home(),
          Perfil.routeName: (context) => const Perfil(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      Future.delayed(
          Duration(milliseconds: 3000),
          (() => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => home(),
                ),
              )));
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
    return splashsc();
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
