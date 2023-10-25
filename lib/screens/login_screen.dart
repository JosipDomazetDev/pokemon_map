import 'package:flutter/material.dart';

import '../blocs/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final LoginBloc bloc;

  LoginScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //#7BED9F
    // 👉🏽
    // #D3D3D3
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
              SizedBox(height: 32.0),

              // Login form
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        controller: usernameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        controller: passwordController,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Login button
              ElevatedButton(
                onPressed: () {
                  widget.bloc.add(AttemptLoginEvent(
                      usernameController.text, passwordController.text));
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
