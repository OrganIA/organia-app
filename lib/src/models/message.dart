import 'package:intl/intl.dart';

class Message {
  int id;
  String createdAt;
  DateTime createdAtOriginal;
  int senderId;
  int chatId;
  String content;

  Message({
    required this.id,
    required this.createdAt,
    required this.createdAtOriginal,
    required this.senderId,
    required this.chatId,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      id: parsedJson["id"],
      createdAt: DateFormat('kk:mm:ss dd/MM/yy')
          .format(DateTime.parse(parsedJson["created_at"]).toLocal()),
      createdAtOriginal: DateTime.parse(parsedJson["created_at"]),
      senderId: parsedJson["sender_id"],
      chatId: parsedJson["chat_id"],
      content: parsedJson["content"],
    );
  }
}
