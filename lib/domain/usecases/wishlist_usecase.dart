import 'package:joes_jwellery_crm/data/repository/wishlist/wishlist_repo.dart';

class WishlistUsecase {
  final WishlistRepository repository ;
  WishlistUsecase(this.repository);

  Future<dynamic> fetchAllWishlist() {
    return repository.getAllWishlist();
  }

  Future<dynamic> fetchSingleWish({required String id}) {
    return repository.getSingleWish(wishId: id);
  }

  Future<dynamic> editWish({
    required Map<String, dynamic> formdata,
  }) {
    return repository.editWish(formdata: formdata);
  }

}