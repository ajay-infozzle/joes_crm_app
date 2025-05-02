import 'package:joes_jwellery_crm/data/repository/call/call_repo.dart';

class CallUseCase {
  final CallRepository repository;
  CallUseCase(this.repository);

  Future<dynamic> fetchCallLog() {
    return repository.getCallLog();
  }
}