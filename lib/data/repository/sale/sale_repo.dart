abstract class SaleRepository {
  Future<dynamic> getSales();
  Future<dynamic> getSingleSale(String id);
  Future<dynamic> deleteSale(String id);
  Future<dynamic> addSale({
    required Map<String, dynamic> formdata,
  });
  Future<dynamic> updateSale({
    required Map<String, dynamic> formdata,
  });
}