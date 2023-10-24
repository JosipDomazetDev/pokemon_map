import 'package:flutter/material.dart';

import '../blocs/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final LoginBloc bloc;

  const LoginScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                bloc.add(AttemptLoginEvent());
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
