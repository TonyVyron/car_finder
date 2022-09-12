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

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text(
              "Hoy, ${DateFormat("Hm").format(DateTime.now())}",
              style: TextStyle(fontSize: 20, fontFamily: 'biko'),
            ),
            Expanded(
              child: MessagesScreen(messages: messages),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              //color: RED_CAR,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    cursorColor: RED_CAR,
                    controller: _PreguntaUsuario,
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
  }
}
