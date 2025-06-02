import 'dart:io';

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
    required String wifePhone,
    required String notes,
  });
  Future<dynamic> addCustomerDetail({
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