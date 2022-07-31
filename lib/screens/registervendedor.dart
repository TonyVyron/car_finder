import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegistroVendedor extends StatefulWidget {
  RegistroVendedor({Key? key}) : super(key: key);

  @override
  State<RegistroVendedor> createState() => _RegistroVendedorState();
}

final TextEditingController nombreVendedor = TextEditingController();
final TextEditingController numeroCelVend = TextEditingController();
final TextEditingController domicilioVend = TextEditingController();
final TextEditingController correoVendedor = TextEditingController();

class _RegistroVendedorState extends State<RegistroVendedor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      height: 680,
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
              Column(children: [
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
                  controller: nombreVendedor,
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
                      onPressed: () => nombreVendedor.clear(),
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
                  controller: numeroCelVend,
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
                      onPressed: () => numeroCelVend.clear(),
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
                  controller: domicilioVend,
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
                      onPressed: () => domicilioVend.clear(),
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
                  controller: correoVendedor,
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
                      onPressed: () => correoVendedor.clear(),
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
                    'Número Postal',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: 'biko', fontSize: 20),
                  ),
                ),
                TextFormField(
                  controller: correoVendedor,
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
                    hintText: 'Ingrese el Número Postal',
                    hintStyle: TextStyle(
                      fontFamily: 'biko',
                    ),
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                      ),
                      onPressed: () => correoVendedor.clear(),
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
                    'Número De Refaccionaría',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: 'biko', fontSize: 20),
                  ),
                ),
                TextFormField(
                  controller: correoVendedor,
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
                    hintText: 'Ingrese el Número',
                    hintStyle: TextStyle(
                      fontFamily: 'biko',
                    ),
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                      ),
                      onPressed: () => correoVendedor.clear(),
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
                    'Domicilio de Refaccionaría',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: 'biko', fontSize: 20),
                  ),
                ),
                TextFormField(
                  controller: correoVendedor,
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
                    hintText: 'Ingrese el Domicilio',
                    hintStyle: TextStyle(
                      fontFamily: 'biko',
                    ),
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                      ),
                      onPressed: () => correoVendedor.clear(),
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
                    'Nombre de Refaccionaria',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: 'biko', fontSize: 20),
                  ),
                ),
                TextFormField(
                  controller: correoVendedor,
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
                    hintText: 'Ingrese su Refaccionaria',
                    hintStyle: TextStyle(
                      fontFamily: 'biko',
                    ),
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                      ),
                      onPressed: () => correoVendedor.clear(),
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
                            style: TextStyle(fontFamily: 'biko', fontSize: 30),
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
                    ),
                  ],
                )
              ]),
              Positioned(
                left: -10,
                child: IconButton(
                    iconSize: 45,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
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
