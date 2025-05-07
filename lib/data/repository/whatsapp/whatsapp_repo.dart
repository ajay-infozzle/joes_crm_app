abstract class WhatsappRepository {
  Future<dynamic> getChatList();
  Future<dynamic> getChatThread({required String chatId});
} 