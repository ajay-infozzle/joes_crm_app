abstract class WishlistRepository {
  Future<dynamic> getAllWishlist();
  Future<dynamic> filterWishlist({required Map<String, dynamic> formdata});
  Future<dynamic> getSingleWish({required String wishId});
  Future<dynamic> editWish({required Map<String, dynamic> formdata});
  Future<dynamic> addWish({required Map<String, dynamic> formdata});
}