import 'package:animate_do/animate_do.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchAuto extends SearchDelegate {
  final String searchFieldLabel;

  SearchAuto(this.searchFieldLabel);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close)),
      IconButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          icon: Icon(Icons.filter_list))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 4; i++)
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return FadeIn(
                            duration: Duration(milliseconds: 600),
                            child: Container(
                              height: 750,
                              child: Scaffold(
                                appBar: AppBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),
                                    backgroundColor: RED_CAR,
                                    title: TextTitulo(text: 'Auto')),
                              ),
                            ));
                      });
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black.withOpacity(.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(197, 0, 0, 0),
                            offset: Offset(4, 4),
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextParrafo(
                                text: 'Chevroley Aveo 2022',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              TextParrafo(
                                text: '\$268,200 MXN',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 140,
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/07_Chevrolet_Aveo.jpg/1200px-07_Chevrolet_Aveo.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextParrafo(
                                text: 'VISA',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              TextParrafo(
                                text: '107 HP',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              TextParrafo(
                                text: '15,000 KM',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 4; i++)
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return FadeIn(
                            duration: Duration(milliseconds: 600),
                            child: Container(
                              height: 750,
                              child: Scaffold(
                                appBar: AppBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),
                                    backgroundColor: RED_CAR,
                                    title: TextTitulo(text: 'Auto')),
                              ),
                            ));
                      });
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black.withOpacity(.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(197, 0, 0, 0),
                            offset: Offset(4, 4),
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextParrafo(
                                text: 'Chevroley Aveo 2022',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              TextParrafo(
                                text: '\$268,200 MXN',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 140,
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/07_Chevrolet_Aveo.jpg/1200px-07_Chevrolet_Aveo.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextParrafo(
                                text: 'VISA',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              TextParrafo(
                                text: '107 HP',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              TextParrafo(
                                text: '15,000 KM',
                                style: TextStyle(
                                  fontFamily: 'biko',
                                  color: Colors.black, //color ?? LABEL_COLOR,
                                  fontSize: LABEL_CAJA,
                                  //fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: RED_CAR,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
                headline6: TextStyle(
                  color: Colors.white,
                  fontFamily: 'biko',
                  fontSize: 20,
                ),
              ),
        );
  }

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
        fontFamily: 'biko',
      );
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
