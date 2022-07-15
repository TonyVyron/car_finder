import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {
  static Future<User?> iniciarSesion({required BuildContext context}) async {
    FirebaseAuth authenticator = FirebaseAuth.instance;
    User? user;

    GoogleSignIn objGoogleSignIn = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount =
        await objGoogleSignIn.signIn();

    if (objGoogleSignInAccount != null) {
      GoogleSignInAuthentication objGoogleSignInAuthentication =
          await objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: objGoogleSignInAuthentication.accessToken,
          idToken: objGoogleSignInAuthentication.idToken);
      try {
        UserCredential userCredential =
            await authenticator.signInWithCredential(credential);

        user = userCredential.user;
        return user;
      } on FirebaseAuthException catch (e) {
        print("Error de autenticación");
      }
    }
  }
}
