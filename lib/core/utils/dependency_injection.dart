import 'package:get_it/get_it.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/auth/auth_repo.dart';
import 'package:joes_jwellery_crm/data/repository/auth/auth_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/call/call_repo.dart';
import 'package:joes_jwellery_crm/data/repository/call/call_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/customer/customer_repo.dart';
import 'package:joes_jwellery_crm/data/repository/customer/customer_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/email/email_repo.dart';
import 'package:joes_jwellery_crm/data/repository/email/email_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/free_item/free_item_repo.dart';
import 'package:joes_jwellery_crm/data/repository/free_item/free_item_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/home/home_repo.dart';
import 'package:joes_jwellery_crm/data/repository/home/home_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/leads/leads_repo.dart';
import 'package:joes_jwellery_crm/data/repository/leads/leads_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/report/report_repo.dart';
import 'package:joes_jwellery_crm/data/repository/report/report_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/sale/sale_repo.dart';
import 'package:joes_jwellery_crm/data/repository/sale/sale_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/sms/sms_repo.dart';
import 'package:joes_jwellery_crm/data/repository/sms/sms_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/task/task_repo.dart';
import 'package:joes_jwellery_crm/data/repository/task/task_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/whatsapp/whatsapp_repo.dart';
import 'package:joes_jwellery_crm/data/repository/whatsapp/whatsapp_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/wishlist/wishlist_repo.dart';
import 'package:joes_jwellery_crm/data/repository/wishlist/wishlist_repo_impl.dart';
import 'package:joes_jwellery_crm/domain/usecases/call_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/customer_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/email_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/free_item_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/home_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/auth_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/leads_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/reports_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/sale_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/sms_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/task_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/whatsapp_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/wishlist_usecase.dart';
import 'package:joes_jwellery_crm/presentation/bloc/auth/auth_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/call/call_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/email/email_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/free_item/free_item_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/leads/leads_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/reports/reports_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sale/sale_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sms/sms_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/task/task_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/whatsapp/whatsapp_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/wishlist/wishlist_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';


final getIt = GetIt.instance;

void dependencyInjection() async{

  //~ shared prefs
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);


  //~ services
  getIt.registerLazySingleton<ApiService>(() => ApiService());


  //~ repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CallRepository>(() => CallRepoImpl(getIt()));
  getIt.registerLazySingleton<WhatsappRepository>(() => WhatsappRepoImpl(getIt()));
  getIt.registerLazySingleton<SmsRepository>(() => SmsRepoImpl(getIt()));
  getIt.registerLazySingleton<LeadsRepository>(() => LeadsRepoImpl(getIt()));
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepoImpl(apiService:getIt()));
  getIt.registerLazySingleton<SaleRepository>(() => SaleRepoImpl(getIt()));
  getIt.registerLazySingleton<EmailRepository>(() => EmailRepoImpl(getIt()));
  getIt.registerLazySingleton<FreeItemRepository>(() => FreeItemRepoImpl(getIt()));
  getIt.registerLazySingleton<WishlistRepository>(() => WishlistRepoImpl(getIt()));
  getIt.registerLazySingleton<ReportRepository>(() => ReportRepoImpl(getIt()));


  //~ usecases 
  getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()));
  getIt.registerLazySingleton<HomeUseCase>(() => HomeUseCase(getIt()));
  getIt.registerLazySingleton<CustomerUseCase>(() => CustomerUseCase(getIt()));
  getIt.registerLazySingleton<CallUseCase>(() => CallUseCase(getIt()));
  getIt.registerLazySingleton<WhatsappUsecase>(() => WhatsappUsecase(getIt()));
  getIt.registerLazySingleton<SmsUsecase>(() => SmsUsecase(getIt()));
  getIt.registerLazySingleton<LeadsUseCase>(() => LeadsUseCase(getIt()));
  getIt.registerLazySingleton<TaskUsecase>(() => TaskUsecase(repository:getIt()));
  getIt.registerLazySingleton<SaleUsecase>(() => SaleUsecase(getIt()));
  getIt.registerLazySingleton<EmailUsecase>(() => EmailUsecase(getIt()));
  getIt.registerLazySingleton<FreeItemUsecase>(() => FreeItemUsecase(getIt()));
  getIt.registerLazySingleton<WishlistUsecase>(() => WishlistUsecase(getIt()));
  getIt.registerLazySingleton<ReportsUsecase>(() => ReportsUsecase(getIt()));


  //~ cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(authUseCase: getIt()));
  getIt.registerFactory<DashboardCubit>(() => DashboardCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit(homeUseCase: getIt()));
  getIt.registerFactory<CustomerCubit>(() => CustomerCubit(customerUseCase: getIt()));
  getIt.registerFactory<CallCubit>(() => CallCubit(callUseCase: getIt()));
  getIt.registerFactory<SmsCubit>(() => SmsCubit(smsUsecase: getIt()));
  getIt.registerFactory<WhatsappCubit>(() => WhatsappCubit(whatsappUsecase: getIt()));
  getIt.registerFactory<LeadsCubit>(() => LeadsCubit(leadsUseCase: getIt()));
  getIt.registerFactory<TaskCubit>(() => TaskCubit(taskUsecase: getIt()));
  getIt.registerFactory<SaleCubit>(() => SaleCubit(saleUsecase: getIt()));
  getIt.registerFactory<EmailCubit>(() => EmailCubit(emailUsecase: getIt()));
  getIt.registerFactory<FreeItemCubit>(() => FreeItemCubit(freeItemUsecase: getIt()));
  getIt.registerFactory<WishlistCubit>(() => WishlistCubit(wishlistUsecase: getIt()));
  getIt.registerFactory<ReportsCubit>(() => ReportsCubit(reportsUsecase: getIt()));

}
