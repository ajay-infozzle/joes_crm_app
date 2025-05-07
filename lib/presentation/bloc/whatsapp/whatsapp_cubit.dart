import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/data/model/whatsapp_chat_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/whatsapp_usecase.dart';

part 'whatsapp_state.dart';

class WhatsappCubit extends Cubit<WhatsappState> {
  final WhatsappUsecase whatsappUsecase;
  WhatsappCubit({required this.whatsappUsecase}) : super(WhatsappInitial());

  Future<void> fetchMsgList() async{
    try {
      emit(WhatsappListLoading());
      final response = await whatsappUsecase.chatList();
      final data = WhatsappChatListModel.fromJson(response);
      emit(WhatsappListLoaded(data));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Whatsapp Cubit");
      emit(WhatsappListError(e.toString()));
    }
  }

  Future<void> fetchMsgThread({required String chatId}) async{
    try {
      emit(WhatsappThreadLoading());
      // final response = await smsUsecase.chatThread(chatId: chatId);
      // final data = SmsChatThreadModel.fromJson(response);
      // emit(SmsListLoaded(data));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Whatsapp Cubit");
      // emit(SmsThreadError(e.toString()));
    }
  }
}
