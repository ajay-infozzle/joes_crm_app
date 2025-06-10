import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/data/model/all_wishlist_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/wishlist_usecase.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistUsecase wishlistUsecase;
  WishlistCubit({required this.wishlistUsecase}) : super(WishlistInitial());
  
  List<Wishlist> wishlist = [];
  Wish? currentWish;

  Future<void> fetchAllWishlist() async {
    try {
      emit(WishlistLoading());
      final response = await wishlistUsecase.fetchAllWishlist();
      final data = AllwishlistModel.fromJson(response);
      wishlist = data.wishlist ?? [] ;
      emit(WishlistLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Wishlist Cubit");
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> filterWishlist({required Map<String, dynamic> formdata}) async {
    try {
      emit(WishlistLoading());
      final response = await wishlistUsecase.filterWishlist(formdata: formdata);
      final data = AllwishlistModel.fromJson(response);
      wishlist = data.wishlist ?? [] ;
      emit(WishlistLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Wishlist Cubit");
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> fetchSingleWish({required String wishId}) async {
    try {
      emit(WishlistLoading());
      final response = await wishlistUsecase.fetchSingleWish(id: wishId);
      final data = SingleWishModel.fromJson(response);
      if(response != null){
        currentWish = data.wish ;
        emit(WishlistLoaded());
      }else{
        emit(WishlistError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Wishlist Cubit");
      emit(WishlistError(e.toString()));
    }
  }
}
