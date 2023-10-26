import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokemon_map/utils/platform_utils.dart';
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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App icon and name
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/icons/android/foreground.png',
                              height: 128.0, width: 128.0),
                          const Text('PokéMap',
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            color: const Color(0xFFE8FFE8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
                                      prefixIcon: Icon(Icons.email),
                                      isDense: true,
                                    ),
                                    style: const TextStyle(fontSize: 12),
                                    controller: usernameController,
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                      prefixIcon: Icon(Icons.lock),
                                      isDense: true,
                                    ),
                                    style: const TextStyle(fontSize: 12),
                                    obscureText: true,
                                    controller: passwordController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Column(
                              children: [
                                SignInButton(
                                  Buttons.email,
                                  text: "Sign up with email",
                                  elevation: 0,
                                  onPressed: () {
                                    widget.bloc.add(AttemptLoginEvent(
                                        usernameController.text,
                                        passwordController.text));
                                  },
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                if (!PlatformUtils.isWindows)
                                  SignInButton(
                                    Buttons.googleDark,
                                    text: "Sign up with Google",
                                    elevation: 0,
                                    onPressed: () async {
                                      widget.bloc
                                          .add(AttemptGoogleLoginEvent());
                                    },
                                  ),
                                const SizedBox(
                                  height: 32.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
