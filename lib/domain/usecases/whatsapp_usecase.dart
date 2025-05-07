import 'package:joes_jwellery_crm/data/repository/whatsapp/whatsapp_repo.dart';

class WhatsappUsecase {
  final WhatsappRepository repository;
  WhatsappUsecase(this.repository);

  Future<dynamic> chatList() {
    return repository.getChatList();
  }

  Future<dynamic> chatThread({required String chatId}) {
    return repository.getChatThread(chatId: chatId);
  }
}