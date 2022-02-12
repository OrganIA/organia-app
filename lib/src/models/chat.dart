class Chat {
  int id;
  List<int> usersIds;
  String chatName;
  int creatorId;

  Chat({
    required this.id,
    required this.usersIds,
    required this.chatName,
    required this.creatorId,
  });

  factory Chat.fromJson(Map<String, dynamic> parsedJson) {
    List<int> usersIds = [];
    for (var i = 0; i < parsedJson["users_ids"].length; i++) {
      usersIds.add(parsedJson["users_ids"][i]["user_id"]);
    }
    return Chat(
      id: parsedJson["id"],
      creatorId: parsedJson["creator_id"],
      chatName: parsedJson["chat_name"].toString(),
      usersIds: usersIds,
    );
  }
}
