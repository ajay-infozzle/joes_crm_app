abstract class AuthRepository {
  Future<dynamic> login(String username, String password);
  Future<dynamic> logout();
}