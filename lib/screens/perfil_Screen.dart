import 'package:car_finder/services/firebase_auth_methods.dart';
import 'package:car_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';

class Perfil extends StatelessWidget {
  static String routeName = '/Perfil';
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // when user signs anonymously or with phone, there is no email
        if (!user.isAnonymous && user.phoneNumber == null) Text(user.email!),
        if (!user.isAnonymous && user.phoneNumber == null)
          Text(user.providerData[0].providerId),
        // display phone number only when user's phone number is not null
        if (user.phoneNumber != null) Text(user.phoneNumber!),
        // uid is always available for every sign in method
        Text(user.uid),
        // display the button only when the user email is not verified
        // or isnt an anonymous user
        if (!user.emailVerified && !user.isAnonymous)
          CustomButton(
            onTap: () {
              context
                  .read<FirebaseAuthMethods>()
                  .sendEmailVerification(context);
            },
            text: 'Verify Email',
          ),
        CustomButton(
          onTap: () {
            context.read<FirebaseAuthMethods>().signOut(context);
          },
          text: 'Sign Out',
        ),
        CustomButton(
          onTap: () {
            context.read<FirebaseAuthMethods>().deleteAccount(context);
          },
          text: 'Delete Account',
        ),
      ],
    );
  }
}
