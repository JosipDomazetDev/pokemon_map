import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_map/repositories/login_repository.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockLoginRepository implements LoginRepository {
  final MockUserCredential _sampleUserCredential = MockUserCredential();

  @override
  Future<UserCredential?> createUserIfNotExist(
      String username, String password) {
    return Future.value(_sampleUserCredential);
  }

  @override
  Future<UserCredential?> login(String username, String password) {
    return Future.value(_sampleUserCredential);
  }

  @override
  Future<UserCredential?> signInWithGoogle() {
    return Future.value(_sampleUserCredential);
  }

  @override
  Future<void> logout() {
    return Future.value();
  }
}
