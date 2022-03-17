class Message {
  int id;
  String createdAt;
  String? updatedAt;
  int senderId;
  int chatId;
  String content;

  Message({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.senderId,
    required this.chatId,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      id: parsedJson["id"],
      createdAt: parsedJson["created_at"],
      updatedAt: parsedJson["updated_at"],
      senderId: parsedJson["sender_id"],
      chatId: parsedJson["chat_id"],
      content: parsedJson["content"],
    );
  }
}
