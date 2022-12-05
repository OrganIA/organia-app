import 'package:intl/intl.dart';
import 'package:organia/src/models/user.dart';

class Message {
  int id;
  String createdAt;
  DateTime createdAtOriginal;
  User sender;
  int chatId;
  String content;

  Message({
    required this.id,
    required this.createdAt,
    required this.createdAtOriginal,
    required this.sender,
    required this.chatId,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      id: parsedJson["id"],
      createdAt: DateFormat('kk:mm:ss dd/MM/yy')
          .format(DateTime.parse(parsedJson["created_at"]).toLocal()),
      createdAtOriginal: DateTime.parse(parsedJson["created_at"]),
      sender: User.fromJson(parsedJson["sender"]),
      chatId: parsedJson["chat"]["id"],
      content: parsedJson["content"],
    );
  }
}
