part of 'sale_cubit.dart';

sealed class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

final class SaleInitial extends SaleState {}
final class SaleFormUpdate extends SaleState {}
final class SaleFormLoading extends SaleState {}
final class SaleAdded extends SaleState {}
