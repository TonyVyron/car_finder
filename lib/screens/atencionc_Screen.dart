import 'package:car_finder/screens/Messages.dart';
import 'package:car_finder/screens/forgot_pw_page.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class Atencionclientes extends StatefulWidget {
  @override
  _AtencionclientesState createState() => _AtencionclientesState();
}

class _AtencionclientesState extends State<Atencionclientes> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _PreguntaUsuario = TextEditingController();

  List<Map<String, dynamic>> messages = [];
  List<Map<String, dynamic>> horas = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  List<String> DiaSemana = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];
  List<String> Mesname = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${DiaSemana[DateTime.now().weekday - 1]} ${DateTime.now().day} de ${Mesname[DateTime.now().month - 1]}",
                    style: TextStyle(fontSize: 20, fontFamily: 'biko'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: messages.isNotEmpty
                  ? MessagesScreen(
                      messages: messages,
                      hora: horas,
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              'assets/logob.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            'Sin mensajes cargados',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'biko',
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      sendMessage(
                        _PreguntaUsuario.text,
                      );
                      _PreguntaUsuario.clear();
                    },
                    autocorrect: true,
                    cursorColor: RED_CAR,
                    controller: _PreguntaUsuario,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                        color: Color.fromARGB(255, 36, 36, 36),
                        fontFamily: 'biko',
                        fontSize: 19),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Escriba su mensaje",
                      hintStyle: TextStyle(
                        fontFamily: ax,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        sendMessage(_PreguntaUsuario.text);
                        _PreguntaUsuario.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: RED_CAR,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('No he escrito mensaje');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
    horas.add({'hora': DateFormat("Hm").format(DateTime.now())});
  }
}
