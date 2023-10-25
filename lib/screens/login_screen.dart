import 'package:flutter/material.dart';

import '../blocs/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final LoginBloc bloc;

  const LoginScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   //#7BED9F
    // 👉🏽
    // #D3D3D3
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 2.0,
            center: Alignment.topLeft,
            colors: [
              Color(0xFF7BED9F),
              Color(0xFFD3D3D3)
            ],
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
                    Text('PokéMap',
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
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Login button
              ElevatedButton(
                onPressed: () {
                  bloc.add(AttemptLoginEvent());
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
