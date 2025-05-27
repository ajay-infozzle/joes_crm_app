import 'package:joes_jwellery_crm/data/repository/home/home_repo.dart';

class HomeUseCase {
  final HomeRepository repository;
  HomeUseCase(this.repository);

  Future<dynamic> call() {
    return repository.fetch();
  }

  Future<dynamic> getStores() {
    return repository.getStores();
  }

  Future<dynamic> getUsers() {
    return repository.getUsers();
  }
}