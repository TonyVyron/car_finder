import 'package:car_finder/screens/registercliente.dart';
import 'package:car_finder/screens/registervendedor.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginTipo extends StatefulWidget {
  LoginTipo({Key? key}) : super(key: key);

  @override
  State<LoginTipo> createState() => _LoginTipoState();
}

final TextEditingController nombreCliente = TextEditingController();
final TextEditingController numeroCel = TextEditingController();

class _LoginTipoState extends State<LoginTipo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo.png"), fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Image.asset('assets/logob.png', width: 230, height: 250),
              Text(
                '¿Como Desea Ingresar?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'biko',
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side:
                                        BorderSide(width: 2, color: RED_CAR)))),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        topRight: Radius.circular(50))),
                                insetPadding: EdgeInsets.all(5),
                                child: Container(
                                  width: double.infinity,
                                  height: 680,
                                  child: RegistroCliente(),
                                ));
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                  width: double.infinity,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 30,
                                  ))),
                          Expanded(
                            flex: 8,
                            child: Container(
                              width: double.infinity,
                              height: 30,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Ingresar Como Cliente',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        width: 2, color: Colors.black)))),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        topRight: Radius.circular(50))),
                                insetPadding: EdgeInsets.all(5),
                                child: RegistroVendedor());
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                  width: double.infinity,
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 30,
                                  ))),
                          Expanded(
                            flex: 8,
                            child: Container(
                              width: double.infinity,
                              height: 30,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Ingresar Como Vendedor',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'biko',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
