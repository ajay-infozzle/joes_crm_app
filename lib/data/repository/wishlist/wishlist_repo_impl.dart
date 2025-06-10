import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/wishlist/wishlist_repo.dart';

class WishlistRepoImpl implements WishlistRepository{
  final ApiService apiService ;
  WishlistRepoImpl(this.apiService);

  @override
  Future editWish({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'wishes',
          'task' : 'editWish',
          'token' : token
        },
        body: FormData.fromMap(formdata)
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future getAllWishlist() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'wishes',
          'task' : 'getWishList',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future filterWishlist({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'wishes',
          'task' : 'getWishList',
          'token' : token
        },
        body: FormData.fromMap(formdata)
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future getSingleWish({required String wishId}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'wishes',
          'task' : 'getWish',
          'token' : token
        },
        body: FormData.fromMap({'id' : wishId})
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}