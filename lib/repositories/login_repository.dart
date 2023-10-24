
class LoginRepository{

  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}