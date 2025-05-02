import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'auth_state.dart';
import '../../../domain/usecases/login_usecase.dart';


class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  // final LogoutUseCase logoutUseCase;
  bool rememberMe = false;

  AuthCubit({
    required this.loginUseCase,
    // required this.logoutUseCase,
  }) : super(AuthInitial());


  void checkInputFields(String username, String password) {
    if(username.trim().isNotEmpty && password.trim().isNotEmpty){
      emit(AuthInputChanged());
    }
    else{
      emit(AuthInitial());
    }
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(AuthRememberMeChanged(rememberMe));
  }

 Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final response = await loginUseCase(username, password);

      final token = response['token'];
      final userId = response['user_id'];

      if (token != null && userId != null) {
        final sessionManager = SessionManager();
        await sessionManager.saveSession(token, userId);
        await sessionManager.storeUser(rememberMe);
        
        emit(AuthAuthenticated(userId));
      } else {
        log("Invalid login response");
        emit(const AuthError('Something went wrong !'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

 Future<bool> logout() async {
    emit(AuthLoggingOut());
    try {
      final sessionManager = SessionManager();
      await sessionManager.clearSession();
      
      emit(AuthLoggedOut());
      return true ;
    } catch (e) {
      emit(AuthLogoutError());
      return false ;
    }
  }

}
