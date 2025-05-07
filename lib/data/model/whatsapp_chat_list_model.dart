class WhatsappChatListModel {
  List<WhatsappChats>? whatsappChats;

  WhatsappChatListModel({this.whatsappChats});

  WhatsappChatListModel.fromJson(Map<String, dynamic> json) {
    if (json['whatsapp_chats'] != null) {
      whatsappChats = <WhatsappChats>[];
      json['whatsapp_chats'].forEach((v) {
        whatsappChats!.add(WhatsappChats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (whatsappChats != null) {
      data['whatsapp_chats'] =
          whatsappChats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WhatsappChats {
  String? name;
  String? lastMessage;
  String? timestamp;
  int? unreadCount;
  String? chatId;

  WhatsappChats(
      {this.name,
      this.lastMessage,
      this.timestamp,
      this.unreadCount,
      this.chatId});

  WhatsappChats.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastMessage = json['last_message'];
    timestamp = json['timestamp'];
    unreadCount = json['unread_count'];
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['last_message'] = lastMessage;
    data['timestamp'] = timestamp;
    data['unread_count'] = unreadCount;
    data['chat_id'] = chatId;
    return data;
  }
}
