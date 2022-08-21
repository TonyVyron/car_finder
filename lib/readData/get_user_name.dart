import 'package:car_finder/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            'Nombre: ${data['Nombre']} ${data['Apellidos']}  ' +
                '\nApellidos: ${data['Apellidos']}' +
                ' \nEdad: ${data['Edad']}' +
                ' \nEmail: ${data['email']}' +
                ' \nStatus: ${data['status']}' +
                ' \nID: ${data['uid']}' +
                ' \nDomicilio: ${data['Direcc']}',
            style: TextStyle(
              fontFamily: 'biko',
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15.5,
            ),
          );
        }
        return Text('cargando...');
      }),
    );
  }
}
