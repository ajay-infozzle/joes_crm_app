import 'package:joes_jwellery_crm/data/repository/free_item/free_item_repo.dart';

class FreeItemUsecase {
  FreeItemRepository repository ;
  FreeItemUsecase(this.repository);

  Future<dynamic> fetchAllFreeItems() {
    return repository.getAllFreeItems();
  }

  Future<dynamic> fetchSingleFreeItem({required String id}) {
    return repository.getSingleFreeItem(itemId: id);
  }

  Future<dynamic> deleteSingleFreeItem({required String id}) {
    return repository.deleteSingleFreeItem(itemId: id);
  }

  Future<dynamic> addFreeItem({
    required Map<String, dynamic> formdata,
  }) {
    return repository.addFreeItem(formdata: formdata);
  }

  Future<dynamic> editFreeItem({
    required Map<String, dynamic> formdata,
  }) {
    return repository.editFreeItem(formdata: formdata);
  }

}