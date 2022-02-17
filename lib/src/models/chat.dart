class Chat {
  int chat_id;
  List<int> usersIds;
  String chatName;
  int creatorId;

  Chat({
    required this.chat_id,
    required this.usersIds,
    required this.chatName,
    required this.creatorId,
  });

  factory Chat.fromJson(Map<String, dynamic> parsedJson) {
    List<int> usersIds = [];
    for (var i = 0; i < parsedJson["users_ids"].length; i++) {
      usersIds.add(parsedJson["users_ids"][i]);
    }
    return Chat(
      chat_id: parsedJson["chat_id"],
      creatorId: parsedJson["creator_id"],
      chatName: parsedJson["chat_name"].toString(),
      usersIds: usersIds,
    );
  }

  @override
  String toString() {
    return "{chat_id: $chat_id, creator_id: $creatorId, chat_name: $chatName, users_ids: $usersIds}";
  }
}
