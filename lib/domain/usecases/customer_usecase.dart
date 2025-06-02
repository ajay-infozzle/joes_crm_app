import 'dart:io';

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
    required String wifePhone,
    required String notes
  }) {
    return repository.editCustomerDetail(id: id, name: name, surname: surname, email: email, phone: phone, country: country, spouseName: spouseName, wifeEmail: wifeEmail, wifePhone: wifePhone,notes: notes);
  }

  Future<dynamic> addCustomer({
    required Map<String, dynamic> formdata,
  }) {
    return repository.addCustomerDetail(formdata: formdata);
  }

  Future<dynamic> sendHimEmail({
    required Map<String, dynamic> formdata,
  }) {
    return repository.sendHimEmail(formdata: formdata);
  }

  Future<dynamic> sendHerEmail({
    required Map<String, dynamic> formdata,
  }) {
    return repository.sendHerEmail(formdata: formdata);
  }

  Future<dynamic> sendWaterTaxiEmail({
    required Map<String, dynamic> formdata,
  }) {
    return repository.sendWaterTaxiEmail(formdata: formdata);
  }

  Future<dynamic> updateCustomerPhoto({
    required File file,
    required String id,
  }) {
    return repository.updateCustomerPhoto(file: file, id: id);
  }

  Future<dynamic> searchCustomer({
    required Map<String, String> formdata,
  }) {
    return repository.searchCustomerDetail(formdata: formdata);
  }

  Future<dynamic> validateEmail({
    required String email,
  }) {
    return repository.validateEmail(email: email);
  }
}