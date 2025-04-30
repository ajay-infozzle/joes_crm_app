import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/customer/customer_repo.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final ApiService apiService;

  CustomerRepositoryImpl(this.apiService);

  @override
  Future<dynamic> getCustomers() async {
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'getCustomers',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }
}