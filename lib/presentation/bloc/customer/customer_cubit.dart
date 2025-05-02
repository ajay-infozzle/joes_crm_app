import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/data/model/customer_list_model.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/customer_usecase.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerUseCase customerUseCase;

  CustomerCubit({required this.customerUseCase}) : super(CustomerInitial());

  Future<void> fetchCustomers() async {
    try {
      emit(CustomerListLoading());
      final response = await customerUseCase.fetchCustomers();
      final data = CustomerListModel.fromJson(response);
      emit(CustomerListLoaded(data.customers??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerListError(e.toString()));
    }
  }

  Future<void> fetchSingleCustomer({required String id}) async {
    try {
      emit(CustomerLoading());
      final response = await customerUseCase.fetchSingleCustomer(id: id);
      final data = SingleCustomerModel.fromJson(response);
      emit(CustomerLoaded(data.customer ?? Customer()));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Customer Cubit");
      emit(CustomerError(e.toString()));
    }
  }
}
