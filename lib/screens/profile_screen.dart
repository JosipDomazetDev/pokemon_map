import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_map/blocs/login_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: buildProfile(),
    );
  }

  Widget buildProfile() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccessState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildUserCred(state),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LogoutEvent());
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Not logged in'),
          );
        }
      },
    );
  }

  Widget buildUserCred(LoginSuccessState state) {
    var user = state.userCredential.user;
    if (user == null) {
      return Center(
        child: Text(
          'Not logged in',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Logged in as ${user.email}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'User display name: ${user.displayName}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'User ID: ${user.uid}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }
}
