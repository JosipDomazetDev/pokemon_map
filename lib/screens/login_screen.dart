import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../blocs/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final LoginBloc bloc;

  const LoginScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 3.0,
            center: Alignment.topLeft,
            colors: [Color(0xFF7BED9F), Color(0xFF26DAC5)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon and name
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/icons/android/foreground.png',
                        height: 128.0, width: 128.0),
                    const Text('PokéMap',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 32.0),

              // Login form
              Card(
                color: Color(0xFFE8FFE8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'Email',
                        ),
                        controller: usernameController,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        controller: passwordController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Login button
              Column(
                children: [
                  SignInButton(
                    Buttons.email,
                    text: "Sign up with email",
                    elevation: 0,
                    onPressed: () {
                      widget.bloc.add(AttemptLoginEvent(
                          usernameController.text, passwordController.text));
                    },
                  ),
                  SignInButton(
                    Buttons.googleDark,
                    text: "Sign up with Google",
                    elevation: 0,
                    onPressed: () async {
                      widget.bloc.add(AttemptGoogleLoginEvent());
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
