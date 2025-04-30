import 'package:joes_jwellery_crm/data/repository/auth/auth_repo.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<dynamic> call(String username, String password) {
    return repository.login(username, password);
  }
}