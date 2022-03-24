import 'package:organia/src/models/message.dart';

class Chat {
  int chatId;
  List<int> usersIds;
  String chatName;
  int creatorId;
  Message latest;

  Chat({
    required this.chatId,
    required this.usersIds,
    required this.chatName,
    required this.creatorId,
    required this.latest,
  });

  factory Chat.fromJson(Map<String, dynamic> parsedJson, Message latest) {
    final List<int> usersIds = [];
    for (var i = 0; i < parsedJson["users_ids"].length; i++) {
      usersIds.add(parsedJson["users_ids"][i]);
    }
    return Chat(
      chatId: parsedJson["chat_id"],
      creatorId: parsedJson["creator_id"],
      chatName: parsedJson["chat_name"],
      usersIds: usersIds,
      latest: latest,
    );
  }

  @override
  String toString() {
    return "{chat_id: $chatId, creator_id: $creatorId, chat_name: $chatName,users_ids: $usersIds}";
  }
}
