class SmsChatListModel {
  List<SmsChats>? smsChats;

  SmsChatListModel({this.smsChats});

  SmsChatListModel.fromJson(Map<String, dynamic> json) {
    if (json['sms_chats'] != null) {
      smsChats = <SmsChats>[];
      json['sms_chats'].forEach((v) {
        smsChats!.add(SmsChats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (smsChats != null) {
      data['sms_chats'] = smsChats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SmsChats {
  String? name;
  String? lastMessage;
  String? timestamp;
  int? unreadCount;
  String? chatId;

  SmsChats(
      {this.name,
      this.lastMessage,
      this.timestamp,
      this.unreadCount,
      this.chatId});

  SmsChats.fromJson(Map<String, dynamic> json) {
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
