part of 'customer_cubit.dart';

sealed class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

final class CustomerInitial extends CustomerState {}


class CustomerListLoading extends CustomerState {}

class CustomerListLoaded extends CustomerState {
  final List<Customers> customers;
  const CustomerListLoaded(this.customers);

  @override
  List<Object> get props => [customers];
}

class CustomerListError extends CustomerState {
  final String message;
  const CustomerListError(this.message);

  @override
  List<Object> get props => [message];
}