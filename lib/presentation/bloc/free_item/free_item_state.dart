part of 'free_item_cubit.dart';

sealed class FreeItemState extends Equatable {
  const FreeItemState();

  @override
  List<Object> get props => [];
}

final class FreeItemInitial extends FreeItemState {}
final class FreeItemsLoading extends FreeItemState {}
class FreeItemsLoaded extends FreeItemState {
  final List<Freeitems> items;
  const FreeItemsLoaded(this.items);

  @override
  List<Object> get props => [items];
}
class FreeItemsError extends FreeItemState {
  final String message;
  const FreeItemsError(this.message);

  @override
  List<Object> get props => [message];
}

final class FreeItemFormUpdate extends FreeItemState {}
final class FreeItemFormLoading extends FreeItemState {}
final class FreeItemFormSaved extends FreeItemState {}
final class FreeItemFormError extends FreeItemState {
  final String message;
  const FreeItemFormError(this.message);

  @override
  List<Object> get props => [message];
}
