part of 'wishlist_cubit.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}
final class WishlistLoaded extends WishlistState {}
final class WishlistError extends WishlistState {
  final String message;
  const WishlistError(this.message);

  @override
  List<Object> get props => [message];
}
