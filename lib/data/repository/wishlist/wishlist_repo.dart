abstract class WishlistRepository {
  Future<dynamic> getAllWishlist();
  Future<dynamic> getSingleWish({required String wishId});
  Future<dynamic> editWish({required Map<String, dynamic> formdata});
}