import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/data/model/call_log_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/call_usecase.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final CallUseCase callUseCase;

  CallCubit({required this.callUseCase}) : super(CallInitial());

  Future<void> fetchCalls() async {
    try {
      emit(CallLogLoading());
      final response = await callUseCase.fetchCallLog();
      final data = CallLogModel.fromJson(response);
      emit(CallLogLoaded(data));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Call Cubit");
      emit(CallLogError(e.toString()));
    }
  }
}
