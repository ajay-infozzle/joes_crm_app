part of 'sale_cubit.dart';

sealed class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

final class SaleInitial extends SaleState {}
final class SaleFormUpdate extends SaleState {}
final class SaleFormLoading extends SaleState {}
final class SaleFormSaved extends SaleState {}

final class SaleListLoading extends SaleState {}
final class SaleListLoaded extends SaleState {
  final List<Sales> saleList;
  const SaleListLoaded(this.saleList);

  @override
  List<Object> get props => [saleList];
}
final class SaleListError extends SaleState {
  final String message;
  const SaleListError(this.message);

  @override
  List<Object> get props => [message];
}

final class SaleLoading extends SaleState {}
final class SaleLoaded extends SaleState {
  final Sale sale;
  const SaleLoaded(this.sale);

  @override
  List<Object> get props => [sale];
}
final class SaleError extends SaleState {
  final String message;
  const SaleError(this.message);

  @override
  List<Object> get props => [message];
}
final class SaleFormError extends SaleState {
  final String message;
  const SaleFormError(this.message);

  @override
  List<Object> get props => [message];
}