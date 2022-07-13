import 'package:car_finder/SplashScreen.dart';
import 'package:car_finder/blocs/theme.dart';
import 'package:flutter/material.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:provider/provider.dart';

void main() => runApp(Aplication());

class Aplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ThemeChanger(ThemeData(
            primaryColor: buildMaterialColor(Color.fromARGB(255, 192, 0, 0)),
            primarySwatch: buildMaterialColor(Color.fromARGB(255, 192, 0, 0)),
            brightness: Brightness.light,
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: Colors.black))),
        child: MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAR FINDER',
      theme: theme.getTheme(),
      home: splashsc(),
    );
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
