import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  final List hora;
  const MessagesScreen({Key? key, required this.messages, required this.hora})
      : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/logo2p.png'),
            colorFilter: ColorFilter.mode(
                Color.fromARGB(20, 244, 67, 54).withOpacity(.1),
                BlendMode.modulate)),
      ),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: widget.messages[index]['isUserMessage']
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  widget.messages[index]['isUserMessage']
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 65,
                          width: 45,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundImage: Image.asset(
                                    'assets/logob.png',
                                    fit: BoxFit.cover,
                                  ).image,
                                  backgroundColor: Colors.white),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.hora[index]['hora'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'biko',
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        border: Border.all(
                            width: 2.5,
                            color: widget.messages[index]['isUserMessage']
                                ? Color.fromARGB(255, 192, 0, 0)
                                : Color.fromARGB(255, 73, 73, 73)
                                    .withOpacity(0.8)),
                        color: widget.messages[index]['isUserMessage']
                            ? Color.fromARGB(255, 192, 0, 0).withOpacity(0.8)
                            : Color.fromARGB(255, 73, 73, 73).withOpacity(0.8),
                      ),
                      constraints: BoxConstraints(maxWidth: w * 2 / 3),
                      child: Text(
                        widget.messages[index]['message'].text.text[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'biko',
                          fontSize: 16,
                        ),
                      )),
                  widget.messages[index]['isUserMessage']
                      ? Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 65,
                          width: 45,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  backgroundImage:
                                      Image.network('${loggedInUser.foto}')
                                          .image,
                                  backgroundColor: Colors.white),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.hora[index]['hora'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'biko',
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
          separatorBuilder: (_, i) =>
              Padding(padding: EdgeInsets.only(top: 10)),
          itemCount: widget.messages.length),
    );
  }
}
