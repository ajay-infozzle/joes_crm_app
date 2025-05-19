import 'package:get_it/get_it.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/auth/auth_repo.dart';
import 'package:joes_jwellery_crm/data/repository/auth/auth_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/call/call_repo.dart';
import 'package:joes_jwellery_crm/data/repository/call/call_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/customer/customer_repo.dart';
import 'package:joes_jwellery_crm/data/repository/customer/customer_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/home/home_repo.dart';
import 'package:joes_jwellery_crm/data/repository/home/home_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/leads/leads_repo.dart';
import 'package:joes_jwellery_crm/data/repository/leads/leads_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/sms/sms_repo.dart';
import 'package:joes_jwellery_crm/data/repository/sms/sms_repo_impl.dart';
import 'package:joes_jwellery_crm/data/repository/whatsapp/whatsapp_repo.dart';
import 'package:joes_jwellery_crm/data/repository/whatsapp/whatsapp_repo_impl.dart';
import 'package:joes_jwellery_crm/domain/usecases/call_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/customer_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/home_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/auth_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/leads_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/sms_usecase.dart';
import 'package:joes_jwellery_crm/domain/usecases/whatsapp_usecase.dart';
import 'package:joes_jwellery_crm/presentation/bloc/auth/auth_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/call/call_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/leads/leads_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sms/sms_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/whatsapp/whatsapp_cubit.dart';
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


  //~ usecases 
  getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()));
  getIt.registerLazySingleton<HomeUseCase>(() => HomeUseCase(getIt()));
  getIt.registerLazySingleton<CustomerUseCase>(() => CustomerUseCase(getIt()));
  getIt.registerLazySingleton<CallUseCase>(() => CallUseCase(getIt()));
  getIt.registerLazySingleton<WhatsappUsecase>(() => WhatsappUsecase(getIt()));
  getIt.registerLazySingleton<SmsUsecase>(() => SmsUsecase(getIt()));
  getIt.registerLazySingleton<LeadsUseCase>(() => LeadsUseCase(getIt()));


  //~ cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(authUseCase: getIt()));
  getIt.registerFactory<DashboardCubit>(() => DashboardCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit(homeUseCase: getIt()));
  getIt.registerFactory<CustomerCubit>(() => CustomerCubit(customerUseCase: getIt()));
  getIt.registerFactory<CallCubit>(() => CallCubit(callUseCase: getIt()));
  getIt.registerFactory<SmsCubit>(() => SmsCubit(smsUsecase: getIt()));
  getIt.registerFactory<WhatsappCubit>(() => WhatsappCubit(whatsappUsecase: getIt()));
  getIt.registerFactory<LeadsCubit>(() => LeadsCubit(leadsUseCase: getIt()));
}
