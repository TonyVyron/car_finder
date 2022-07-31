import 'package:car_finder/Authenticator.dart';
import 'package:car_finder/screens/atencionc_Screen.dart';
import 'package:car_finder/screens/autoscaja.dart';
import 'package:car_finder/screens/favoritos_Screen.dart';
import 'package:car_finder/screens/filtro_Screen.dart';
import 'package:car_finder/screens/historial_Screen.dart';
import 'package:car_finder/screens/logintipo.dart';
//import 'package:car_finder/screens/inicio_Screen.dart';
import 'package:car_finder/screens/perfil_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:car_finder/widgets/search_Auto.dart';
import 'package:flutter/material.dart';
import 'package:car_finder/widgets/widgets.dart';
//import 'package:flutter/widgets.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final user = FirebaseAuth.instance.currentUser!;

  int selectDrawerItem = 1;
  final _passwordController = TextEditingController();
  bool _passwordVisible = true;

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Perfil();
      case 1:
        return CajaAutos();
      case 2:
        return Historial();
      case 3:
        return Favoritos();
      case 4:
        return Atencion_Clientes();
      case 5:
        return LoginTipo();
    }
  }

  onSelectItem(int pos) {
    Navigator.pop(context);
    setState(() {
      selectDrawerItem = pos;
    });
  }

  onSelectItem2(int pos) {
    setState(() {
      selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: RED_CAR,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Container(
              width: double.infinity,
              child: TextTitulo(
                  text: selectDrawerItem == 0
                      ? "Perfil de Usuario"
                      : selectDrawerItem == 1
                          ? "Recomendaciones"
                          : selectDrawerItem == 2
                              ? "Historial"
                              : selectDrawerItem == 3
                                  ? "Favoritos"
                                  : selectDrawerItem == 4
                                      ? "Atención A Clientes"
                                      : "Login Tipo")),
          actions: selectDrawerItem == 1
              ? [filtroautos()]
              : [
                  IconButton(
                      onPressed: () {
                        onSelectItem2(0);
                      },
                      icon: CircleAvatar(
                        radius: 30,
                        child: Container(
                          height: 30,
                          width: 34,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(
                                        'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg')
                                    .image,
                                fit: BoxFit.cover),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ))
                ],
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(bottom: 2),
              color: RED_CAR,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Container(
                      //   padding: EdgeInsets.all(2),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Colors.white,
                      //         width: 5,
                      //       ),
                      //       shape: BoxShape.circle),
                      //   child: Icon(
                      //     Icons.person,
                      //     size: 70,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      CircleAvatar(
                        radius: 40,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(
                                        'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg')
                                    .image,
                                fit: BoxFit.cover),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            child: TextParrafo(text: 'Cliente'),
                          ),
                          Container(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextParrafo(text: 'Ver perfil'),
                                IconButton(
                                    iconSize: 35,
                                    onPressed: () {
                                      onSelectItem(0);
                                    },
                                    icon: Icon(
                                      Icons.arrow_circle_right,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: TextParrafo(
                      text: '' + user.email!,
                      style: TextStyle(
                        fontFamily: 'biko',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment(0, 0),
                      height: 50,
                      color: selectDrawerItem == 1
                          ? Color.fromARGB(255, 227, 226, 226)
                          : Color.fromARGB(0, 0, 0, 0),
                      margin: EdgeInsets.only(bottom: 2),
                      child: ListTile(
                        title: TextParrafo(
                          text: 'Home',
                          style: TextStyle(
                            fontFamily: 'biko',
                            color: RED_CAR,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        leading: Icon(
                          Icons.home,
                          color: RED_CAR,
                          size: 30,
                        ),
                        onTap: () {
                          onSelectItem(1);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      height: 50,
                      color: selectDrawerItem == 2
                          ? Color.fromARGB(255, 227, 226, 226)
                          : Color.fromARGB(0, 0, 0, 0),
                      margin: EdgeInsets.only(bottom: 2),
                      child: ListTile(
                        title: TextParrafo(
                          text: 'Historial',
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: RED_CAR),
                        ),
                        leading: Icon(
                          Icons.history,
                          color: RED_CAR,
                          size: 30,
                        ),
                        onTap: () {
                          onSelectItem(2);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      height: 50,
                      color: selectDrawerItem == 3
                          ? Color.fromARGB(255, 227, 226, 226)
                          : Color.fromARGB(0, 0, 0, 0),
                      margin: EdgeInsets.only(bottom: 2),
                      child: ListTile(
                        title: TextParrafo(
                          text: 'Favoritos',
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: RED_CAR),
                        ),
                        leading: Icon(
                          Icons.favorite,
                          color: RED_CAR,
                          size: 30,
                        ),
                        onTap: () {
                          onSelectItem(3);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      height: 50,
                      color: selectDrawerItem == 5
                          ? Color.fromARGB(255, 227, 226, 226)
                          : Color.fromARGB(0, 0, 0, 0),
                      margin: EdgeInsets.only(bottom: 2),
                      child: ListTile(
                        title: TextParrafo(
                          text: 'Login Tipo',
                          style: TextStyle(
                              fontFamily: 'biko',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: RED_CAR),
                        ),
                        leading: Icon(
                          Icons.login,
                          color: RED_CAR,
                          size: 30,
                        ),
                        onTap: () {
                          onSelectItem(5);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.only(bottom: 2),
              color: RED_CAR,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment(0, 0),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 2),
                    child: ListTile(
                      selected: false,
                      title: TextParrafo(
                        text: 'Atención a Clientes',
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.face_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        onSelectItem(3);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 2),
                    child: ListTile(
                      selected: false,
                      title: TextParrafo(
                        text: 'Cerrar sesión',
                        style: TextStyle(
                            fontFamily: 'biko',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(50))),
                                  backgroundColor: Colors.white,
                                  title: Text("Cerrar Sesión",
                                      style: TextStyle(
                                        fontFamily: 'biko',
                                        color: Colors.black,
                                        fontSize: 25,
                                      )),
                                  content: Text(
                                      "Está a punto de salir, ¿realmente desea hacerlo?",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: 'biko',
                                      )),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          color: RED_CAR,
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                fontFamily: 'biko',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        FirebaseAuth.instance.signOut();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            right: 13,
                                            top: 10,
                                            bottom: 10,
                                            left: 13),
                                        color: RED_CAR,
                                        child: Text(
                                          "Si",
                                          style: TextStyle(
                                              fontFamily: 'biko',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
        body: getDrawerItemWidget(selectDrawerItem));
  }
}
