import 'package:joes_jwellery_crm/data/repository/auth/auth_repo.dart';

class AuthUseCase {
  final AuthRepository repository;
  AuthUseCase(this.repository);

  Future<dynamic> login(String username, String password) {
    return repository.login(username, password);
  }

  Future<dynamic> logout() {
    return repository.logout();
  }
}