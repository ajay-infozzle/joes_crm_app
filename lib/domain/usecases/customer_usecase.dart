import 'package:joes_jwellery_crm/data/repository/customer/customer_repo.dart';

class CustomerUseCase {
  final CustomerRepository repository;
  CustomerUseCase(this.repository);

  Future<dynamic> fetchCustomers() {
    return repository.getCustomers();
  }

  Future<dynamic> fetchSingleCustomer({required String id}) {
    return repository.getCustomerDetail(id);
  }
}