import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/domain/usecases/wishlist_usecase.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistUsecase wishlistUsecase;
  WishlistCubit({required this.wishlistUsecase}) : super(WishlistInitial());
  
}
