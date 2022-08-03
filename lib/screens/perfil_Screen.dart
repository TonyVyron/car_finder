import 'package:car_finder/readData/get_user_name.dart';
import 'package:car_finder/widgets/widgets.dart';
//import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var ax = "biko";

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final user = FirebaseAuth.instance.currentUser!;
  //documents IDs
  List<String> docIDs = [];

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correo: ' + user.email!,
              style: TextStyle(
                fontFamily: ax,
                fontSize: 25,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            title: GetUserName(documentId: docIDs[index]),
                            tileColor: Colors.grey[200],
                          ),
                        );
                      }),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
