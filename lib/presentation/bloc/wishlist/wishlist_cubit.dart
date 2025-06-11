import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/custome_image_picker.dart';
import 'package:joes_jwellery_crm/data/model/all_wishlist_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/wishlist_usecase.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistUsecase wishlistUsecase;
  WishlistCubit({required this.wishlistUsecase}) : super(WishlistInitial());
  
  List<Wishlist> wishlist = [];
  Wish? currentWish;

  File? currentPickedImg ;
  Future<void> pickImage() async {
    final picked = await CustomeImagePicker.pickImageFromGallery(); 
    if (picked != null) {
      currentPickedImg = picked;
      if(state is WishFormUpdate){
        emit(WishlistInitial());
        emit(WishFormUpdate());
      }
      else{
        emit(WishFormUpdate());
      }
    }
  }

  void updateForm(){
    if(state is WishFormUpdate){
      emit(WishlistInitial());
      emit(WishFormUpdate());
    }
  }

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

  Future<void> addWish({required Map<String, dynamic> formdata}) async {
    try {
      emit(WishFormLoading());
      if(currentPickedImg!=null){
        formdata['photo'] = await MultipartFile.fromFile(
          currentPickedImg?.path ?? "", 
          filename: "${DateTime.now().millisecondsSinceEpoch}.jpg",
          contentType: MediaType('image', 'jpeg')
        );
      }
      
      final response = await wishlistUsecase.addWish(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        currentPickedImg = null ;
        emit(WishFormSaved());
      }else{
        emit(WishFormError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Wishlist Cubit");
      emit(WishFormError(e.toString()));
    }
  }

  Future<void> editWish({required Map<String, dynamic> formdata}) async {
    try {
      emit(WishFormLoading());
      final response = await wishlistUsecase.editWish(formdata: formdata);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        currentPickedImg = null ;
        emit(WishFormSaved());
      }else{
        showToast(msg: "try again !", backColor: AppColor.red);
        emit(WishFormError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Wishlist Cubit");
      emit(WishFormError(e.toString()));
    }
  }

}
