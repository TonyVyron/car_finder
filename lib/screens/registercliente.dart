import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegistroCliente extends StatefulWidget {
  RegistroCliente({Key? key}) : super(key: key);

  @override
  State<RegistroCliente> createState() => _RegistroClienteState();
}

final TextEditingController nombreCliente = TextEditingController();
final TextEditingController numeroCel = TextEditingController();
final TextEditingController domicilioCliente = TextEditingController();
final TextEditingController correoCliente = TextEditingController();

class _RegistroClienteState extends State<RegistroCliente> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 680,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50), topRight: Radius.circular(50)),
          image: DecorationImage(
              image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(140),
                        child: Image.network(
                          'https://static.vecteezy.com/system/resources/previews/007/319/933/non_2x/black-avatar-person-icons-user-profile-icon-vector.jpg',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.maxFinite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, bottom: 5),
                    width: double.infinity,
                    child: Text(
                      'Nombre',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'biko', fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    controller: nombreCliente,
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
                      hintText: 'Ingrese su Nombre',
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      prefixIcon: Icon(Icons.man),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () => nombreCliente.clear(),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, bottom: 5),
                    width: double.infinity,
                    child: Text(
                      'Número de Celular',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'biko', fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    controller: numeroCel,
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
                      hintText: 'Ingrese su Número',
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      prefixIcon: Icon(Icons.numbers),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () => numeroCel.clear(),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, bottom: 5),
                    width: double.infinity,
                    child: Text(
                      'Domicilio',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'biko', fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    controller: domicilioCliente,
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
                      hintText: 'Ingrese su Domicilio',
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      prefixIcon: Icon(Icons.home),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () => domicilioCliente.clear(),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, bottom: 5),
                    width: double.infinity,
                    child: Text(
                      'Correo Electrónico',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'biko', fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    controller: correoCliente,
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
                      hintText: 'Ingrese su Correo',
                      hintStyle: TextStyle(
                        fontFamily: 'biko',
                      ),
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () => correoCliente.clear(),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Registrar',
                              style:
                                  TextStyle(fontFamily: 'biko', fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              iconSize: 60,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_circle_right,
                                color: RED_CAR,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                left: -10,
                child: IconButton(
                    iconSize: 45,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.man,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
