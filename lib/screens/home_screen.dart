import 'package:car_finder/imageupload/mis_carros.dart';
import 'package:car_finder/models/user_model.dart';
import 'package:car_finder/screens/atencionc_Screen.dart';
import 'package:car_finder/screens/autoscaja.dart';
import 'package:car_finder/screens/favoritos_Screen.dart';
import 'package:car_finder/screens/formulario_carro.dart';
import 'package:car_finder/screens/Promo_Screen.dart';
import 'package:car_finder/screens/perfil_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:car_finder/widgets/widgets.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int selectDrawerItem = 1;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();
  final searchcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  String tete = 'Trabajo';
  String titi = 'Trasera';

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Perfil();
      case 1:
        return CajaAutos(
          QueryTexto: searchcontroller.text,
        );
      case 2:
        return Promociones(
          QueryTexto: searchcontroller.text,
        );
      case 3:
        return Favoritos();
      case 4:
        return Atencionclientes();
      case 5:
        return Agregar_Carro();
      case 6:
        return mis_carros();
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

  getitulo(String selectDrawerItem) {
    switch (selectDrawerItem) {
      case "0":
        return loggedInUser.status.toString() == 'Vendedor'
            ? "Perfil de la tienda"
            : "Perfil de usuario";
      case "1":
        return "Home";
      case "2":
        return "Promociones";
      case "3":
        return "Favoritos";
      case "4":
        return loggedInUser.status.toString() == 'Vendedor'
            ? "Atención a vendedores"
            : "Atención a clientes";
      case "5":
        return "Agregar un vehículo";
      case "6":
        return "Mis vehículos";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: selectDrawerItem != 0
            ? _appBar(AppBar().preferredSize.height)
            : AppBar(
                elevation: 0,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        RED_CAR,
                        RED_CAR,
                      ]),
                )),
                title: Container(
                  alignment: Alignment.center,
                  child: Expanded(
                      child: TextTitulo(
                          text: getitulo(selectDrawerItem.toString()))),
                ),
                actions: [
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
                                image: Image.asset('assets/IconApp.png').image,
                                fit: BoxFit.cover),
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )),
                ],
              ),
        drawer: ClipPath(
          clipper: Mycustomclipper3(),
          child: Drawer(
              child: ListView(
            children: [
              SingleChildScrollView(
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    height: 280,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color.fromARGB(255, 192, 0, 0),
                            Color.fromARGB(198, 255, 94, 94),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50))),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            top: 20,
                            right: 30,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 40,
                                ))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.bottomLeft,
                                width: double.infinity,
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('uid',
                                            isEqualTo: loggedInUser.uid)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Center(
                                              child: Transform.scale(
                                            scale: 1.6,
                                            child: CircularProgressIndicator(
                                              color: RED_CAR,
                                            ),
                                          )),
                                        );
                                      } else {
                                        QueryDocumentSnapshot<Object?> perfil =
                                            snapshot.data!.docs[0];
                                        return Container(
                                          alignment: Alignment.centerLeft,
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.white, width: .5),
                                            image: DecorationImage(
                                                image: perfil['foto'] == null
                                                    ? Image.network(
                                                            'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg')
                                                        .image
                                                    : Image.network(
                                                            '${perfil['foto']}')
                                                        .image,
                                                fit: BoxFit.cover),
                                            color: Colors.white,
                                            shape: BoxShape.rectangle,
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .where('uid', isEqualTo: loggedInUser.uid)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Center(
                                            child: Transform.scale(
                                          scale: 1.6,
                                          child: CircularProgressIndicator(
                                            color: RED_CAR,
                                          ),
                                        )),
                                      );
                                    } else {
                                      QueryDocumentSnapshot<Object?> perfil =
                                          snapshot.data!.docs[0];
                                      return Text(
                                        '${perfil['Nombre']} ${perfil['Apellidos']}',
                                        style: TextStyle(
                                            fontFamily: 'biko',
                                            fontSize: 24.5,
                                            color: Colors.white),
                                      );
                                    }
                                  }),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: Text(
                                      'Ver mi perfil',
                                      style: TextStyle(
                                          fontFamily: 'biko',
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      onSelectItem(0);
                                    },
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30),
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
                              color: Colors.black,
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
                      if (loggedInUser.status.toString() == 'Cliente')
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          alignment: Alignment(0, 0),
                          height: 50,
                          color: selectDrawerItem == 2
                              ? Color.fromARGB(255, 227, 226, 226)
                              : Color.fromARGB(0, 0, 0, 0),
                          margin: EdgeInsets.only(bottom: 2),
                          child: ListTile(
                            title: TextParrafo(
                              text: 'Promociones',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            leading: Icon(
                              Icons.discount_rounded,
                              color: RED_CAR,
                              size: 30,
                            ),
                            onTap: () {
                              onSelectItem(2);
                            },
                          ),
                        ),
                      if (loggedInUser.status.toString() == 'Cliente')
                        Container(
                          padding: EdgeInsets.only(left: 30),
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
                                  color: Colors.black),
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
                      if (loggedInUser.status.toString() == 'Vendedor')
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          alignment: Alignment(0, 0),
                          height: 50,
                          color: selectDrawerItem == 5
                              ? Color.fromARGB(255, 227, 226, 226)
                              : Color.fromARGB(0, 0, 0, 0),
                          margin: EdgeInsets.only(bottom: 2),
                          child: ListTile(
                            title: TextParrafo(
                              text: 'Agregar un vehículo',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            leading: Icon(
                              Icons.shopping_bag,
                              color: RED_CAR,
                              size: 30,
                            ),
                            onTap: () {
                              onSelectItem(5);
                            },
                          ),
                        ),
                      if (loggedInUser.status.toString() == 'Vendedor')
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          alignment: Alignment(0, 0),
                          height: 50,
                          color: selectDrawerItem == 6
                              ? Color.fromARGB(255, 227, 226, 226)
                              : Color.fromARGB(0, 0, 0, 0),
                          margin: EdgeInsets.only(bottom: 2),
                          child: ListTile(
                            title: TextParrafo(
                              text: 'Mis vehículos',
                              style: TextStyle(
                                  fontFamily: 'biko',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            leading: Icon(
                              Icons.car_rental,
                              color: RED_CAR,
                              size: 30,
                            ),
                            onTap: () {
                              onSelectItem(6);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                margin: EdgeInsets.only(bottom: 2),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment(0, 0),
                      height: 50,
                      color: selectDrawerItem == 4
                          ? Color.fromARGB(255, 227, 226, 226)
                          : Color.fromARGB(0, 0, 0, 0),
                      margin: EdgeInsets.only(bottom: 2),
                      child: ListTile(
                        selected: false,
                        title: Text(
                            loggedInUser.status == 'Cliente'
                                ? 'Atención a clientes'
                                : 'Atención a vendedor',
                            style: TextStyle(
                                fontFamily: 'biko',
                                fontWeight: FontWeight.w500,
                                fontSize: loggedInUser.status == 'Cliente'
                                    ? 18
                                    : 17.5,
                                color: Colors.black)),
                        leading: loggedInUser.status == 'Cliente'
                            ? Icon(
                                Icons.person,
                                color: RED_CAR,
                                size: 30,
                              )
                            : Icon(
                                Icons.shopping_cart,
                                color: RED_CAR,
                                size: 30,
                              ),
                        onTap: () {
                          onSelectItem(4);
                        },
                      ),
                    ),
                    Container(
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
                              color: Colors.black),
                        ),
                        leading: Icon(
                          Icons.login_rounded,
                          color: RED_CAR,
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
                                    title: Text("Cerrar sesión",
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
                                          setState(() {
                                            FirebaseAuth.instance.signOut();
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 13,
                                              top: 10,
                                              bottom: 10,
                                              left: 13),
                                          color: RED_CAR,
                                          child: Text(
                                            "Sí",
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
        ),
        body: getDrawerItemWidget(selectDrawerItem));
  }

  _appBar(height) => PreferredSize(
      preferredSize: Size(
          MediaQuery.of(context).size.width,
          selectDrawerItem == 1 ||
                  selectDrawerItem == 2 ||
                  selectDrawerItem == 6
              ? height + 55
              : height + 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          ClipPath(
            clipper: Mycustomclipper(),
            child: Container(
              padding: selectDrawerItem == 1 ||
                      selectDrawerItem == 2 ||
                      selectDrawerItem == 6
                  ? EdgeInsets.only(top: 10, bottom: 30)
                  : EdgeInsets.only(top: 35, bottom: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [RED_CAR, Color.fromARGB(177, 192, 0, 0)],
                ),
              ),
              child: Center(
                  child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      icon: new Icon(
                        Icons.menu,
                        size: 28,
                        color: Colors.white,
                      ),
                      onPressed: () => _scaffoldkey.currentState?.openDrawer(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Expanded(
                        flex: 6,
                        child: TextTitulo(
                            text: getitulo(selectDrawerItem.toString()))),
                  ),
                  Expanded(
                    flex: 2,
                    child: selectDrawerItem == 4
                        ? Container()
                        : StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('uid', isEqualTo: loggedInUser.uid)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Center(
                                      child: Transform.scale(
                                    scale: 1.6,
                                    child: CircularProgressIndicator(
                                      color: RED_CAR,
                                    ),
                                  )),
                                );
                              } else {
                                QueryDocumentSnapshot<Object?> perfil =
                                    snapshot.data!.docs[0];
                                return IconButton(
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
                                              image: perfil['foto'] == null
                                                  ? Image.network(
                                                          'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg')
                                                      .image
                                                  : Image.network(
                                                          '${perfil['foto']}')
                                                      .image,
                                              fit: BoxFit.cover),
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ));
                              }
                            }),
                  )
                ],
              )),
            ),
          ),
          if (selectDrawerItem == 1 ||
              selectDrawerItem == 2 ||
              selectDrawerItem == 6)
            Positioned(
              // To take AppBar Size only
              top: 85.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: RED_CAR)),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white,
                  primary: false,
                  title: TextFormField(
                      controller: searchcontroller,
                      enabled: selectDrawerItem == 1 ||
                              selectDrawerItem == 2 ||
                              selectDrawerItem == 6
                          ? true
                          : false,
                      onChanged: (value) {
                        setState(() {});
                      },
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                          fontFamily: 'biko',
                          fontWeight: FontWeight.w500,
                          color: selectDrawerItem == 1 ||
                                  selectDrawerItem == 2 ||
                                  selectDrawerItem == 6
                              ? Colors.black
                              : Colors.black.withOpacity(.4)),
                      decoration: InputDecoration(
                          hintText: "Buscar..",
                          prefixIcon: IconButton(
                            padding: EdgeInsets.only(bottom: 5, right: 12),
                            onPressed: () {},
                            icon: Icon(
                              Icons.directions_car,
                              size: 26,
                              color: RED_CAR,
                            ),
                          ),
                          suffixIcon: IconButton(
                            padding: EdgeInsets.only(left: 12, bottom: 5),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            icon: Icon(
                              Icons.search,
                              size: 24,
                              color: RED_CAR,
                            ),
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: selectDrawerItem == 1 ||
                                      selectDrawerItem == 2 ||
                                      selectDrawerItem == 6
                                  ? Colors.black
                                  : Colors.black.withOpacity(.4)))),
                ),
              ),
            ),
        ],
      ));
}

class Mycustomclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Mycustomclipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 50, size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Mycustomclipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
