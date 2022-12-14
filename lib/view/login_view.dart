import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:login/constants/routes.dart';

import '../main.dart';
import '../utillities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('login')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter your Password'),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    // devtools.log('user not found');
                    await shoeErrorDialog(
                      context,
                      'User not found',
                    );
                  } else if (e.code == 'wrong-password') {
                    //devtools.log('Wrong password');
                    await shoeErrorDialog(context, 'Wrong password');
                  } else {
                    await shoeErrorDialog(
                      context,
                      'Error: ${e.code}',
                    );                           // dont understand in this code
                  }
                } catch (e) {
                  await shoeErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              },
              child: const Text('Login..')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text("Not registered yet? Register here")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  notesRoute,
                  (route) => false,
                );
              },
              child: const Text("menu"))
        ],
      ),
    );
  }
}
