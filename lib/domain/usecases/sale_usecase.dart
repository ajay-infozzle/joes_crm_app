import 'package:joes_jwellery_crm/data/repository/sale/sale_repo.dart';

class SaleUsecase {
  final SaleRepository repository;
  SaleUsecase(this.repository);

  Future<dynamic> fetchSales() {
    return repository.getSales();
  }

  Future<dynamic> fetchSingleSale({required String id}) {
    return repository.getSingleSale(id);
  }

  Future<dynamic> addSale({
    required Map<String, dynamic> formdata,
  }) {
    return repository.addSale(formdata: formdata);
  }

  Future<dynamic> updateSale({
    required Map<String, dynamic> formdata,
  }) {
    return repository.updateSale(formdata: formdata);
  }

  Future<dynamic> deleteSale({required String id}) {
    return repository.deleteSale(id);
  }

}