abstract class SmsRepository {
  Future<dynamic> getChatList();
  Future<dynamic> getChatThread({required String chatId});
} 