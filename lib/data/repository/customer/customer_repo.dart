abstract class CustomerRepository {
  Future<dynamic> getCustomers();
  Future<dynamic> getCustomerDetail(String id);
}