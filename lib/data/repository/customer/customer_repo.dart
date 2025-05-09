abstract class CustomerRepository {
  Future<dynamic> getCustomers();
  Future<dynamic> getCustomerDetail(String id);
  Future<dynamic> editCustomerDetail({
    required String id,
    required String name,
    required String surname,
    required String email,
    required String phone,
    required String country,
    required String spouseName,
    required String wifeEmail,
    required String wifePhone
  });
}