import 'dart:io';

abstract class CustomerRepository {
  Future<dynamic> getCustomers();
  Future<dynamic> filterCustomers({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> getCustomerDetail(String id);
  Future<dynamic> editCustomerDetail({required Map<String, dynamic> formdata});
  Future<dynamic> addCustomerDetail({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> addNote({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> sendHimEmail({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> sendHerEmail({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> sendWaterTaxiEmail({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> sendApprCertEmail({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> updateCustomerPhoto({
    required File file,
    required String id,
  });
  Future<dynamic> searchCustomerDetail({
    required Map<String, String> formdata,
  });
  Future<dynamic> validateEmail({
    required String email,
  });
}