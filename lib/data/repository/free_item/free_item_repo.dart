abstract class FreeItemRepository {
  Future<dynamic> getAllFreeItems();
  Future<dynamic> getSingleFreeItem({required String itemId});
  Future<dynamic> deleteSingleFreeItem({required String itemId});
  Future<dynamic> addFreeItem({required Map<String, dynamic> formdata});
  Future<dynamic> editFreeItem({required Map<String, dynamic> formdata});
}