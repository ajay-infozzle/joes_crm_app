import 'package:joes_jwellery_crm/data/repository/sms/sms_repo.dart';

class SmsUsecase {
  final SmsRepository repository;
  SmsUsecase(this.repository);

  Future<dynamic> chatList() {
    return repository.getChatList();
  }

  Future<dynamic> chatThread({required String chatId}) {
    return repository.getChatThread(chatId: chatId);
  }
}