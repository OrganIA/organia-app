import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';

class Chat {
  int chatId;
  List<User> users;
  String chatName;
  User creator;
  Message? latest;

  Chat({
    required this.chatId,
    required this.users,
    required this.chatName,
    required this.creator,
    required this.latest,
  });

  factory Chat.fromJson(Map<String, dynamic> parsedJson, Message? latest) {
    List<User> users = [];
    for (var i = 0; i < parsedJson["users"].length; i++) {
      users.add(User.fromJson(parsedJson["users"][i]));
    }
    return Chat(
      chatId: parsedJson["id"],
      creator: User.fromJson(parsedJson["creator"]),
      chatName: parsedJson["name"],
      users: users,
      latest: latest,
    );
  }

  @override
  String toString() {
    return "{chat_id: $chatId, creator: $creator, chat_name: $chatName,users: $users}";
  }
}
