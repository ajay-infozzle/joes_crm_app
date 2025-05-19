part of 'customer_cubit.dart';

sealed class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

final class CustomerInitial extends CustomerState {}


class CustomerLoading extends CustomerState {}
class CustomerListLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final Customer customer;
  const CustomerLoaded(this.customer);

  @override
  List<Object> get props => [customer];
}

class CustomerListLoaded extends CustomerState {
  final List<Customers> customers;
  const CustomerListLoaded(this.customers);

  @override
  List<Object> get props => [customers];
}

class CustomerError extends CustomerState {
  final String message;
  const CustomerError(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerListError extends CustomerState {
  final String message;
  const CustomerListError(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerAddFormLoading extends CustomerState {
  
  @override
  List<Object> get props => [];
}

class CustomerAddFormUpdate extends CustomerState {
  
  @override
  List<Object> get props => [];
}

class CustomerAddFormSubmitted extends CustomerState {
  
  @override
  List<Object> get props => [];
}

class CustomerExistVerifying extends CustomerState {
  
  @override
  List<Object> get props => [];
}
class CustomerExist extends CustomerState {
  
  @override
  List<Object> get props => [];
}
class CustomerNotExist extends CustomerState {
  
  @override
  List<Object> get props => [];
}

class CustomerAddError extends CustomerState {
  final String message;
  const CustomerAddError(this.message);

  @override
  List<Object> get props => [message];
}
class CustomerExistError extends CustomerState {
  final String message;
  const CustomerExistError(this.message);

  @override
  List<Object> get props => [message];
}