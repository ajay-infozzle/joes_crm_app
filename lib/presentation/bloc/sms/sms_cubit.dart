import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/data/model/sms_chat_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/sms_usecase.dart';

part 'sms_state.dart';

class SmsCubit extends Cubit<SmsState> {
  final SmsUsecase smsUsecase;

  SmsCubit({required this.smsUsecase}) : super(SmsInitial());

  Future<void> fetchSmsList() async{
    try {
      emit(SmsListLoading());
      final response = await smsUsecase.chatList();
      final data = SmsChatListModel.fromJson(response);
      emit(SmsListLoaded(data));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sms Cubit");
      emit(SmsListError(e.toString()));
    }
  }

  Future<void> fetchSmsThread({required String chatId}) async{
    try {
      emit(SmsThreadLoading());
      // final response = await smsUsecase.chatThread(chatId: chatId);
      // final data = SmsChatThreadModel.fromJson(response);
      // emit(SmsListLoaded(data));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Sms Cubit");
      // emit(SmsThreadError(e.toString()));
    }
  }

}
