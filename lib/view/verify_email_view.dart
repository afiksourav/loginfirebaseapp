
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:login/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('verify email')),
      body: Column(
        children: [
          const Text("place verify your email address"),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                print(user);

                
              },
              child: const Text('sent email verification')),

              TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false,
                          );

              }, child: const Text('login')),
        ],
      ),
    );
  }
}
