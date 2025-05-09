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

  Future<dynamic> editCustomer({
    required String id,
    required String name,
    required String surname,
    required String email,
    required String phone,
    required String country,
    required String spouseName,
    required String wifeEmail,
    required String wifePhone
  }) {
    return repository.editCustomerDetail(id: id, name: name, surname: surname, email: email, phone: phone, country: country, spouseName: spouseName, wifeEmail: wifeEmail, wifePhone: wifePhone);
  }
}