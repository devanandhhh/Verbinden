class ChatMessage {
  final String? messageId;
  final String? senderId;
  final String? recipientId;
  final String? content;
  final String? status;
  final String? timeStamp;

  ChatMessage(
      {this.messageId,
      this.senderId,
      this.recipientId,
      this.content,
      this.status,
      this.timeStamp});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        messageId: json['messageID'],
        senderId: json['SenderID'],
        recipientId: json['RecieverID'],
        content: json['Content'],
        status: json['Status'],
        timeStamp: json['TimeStamp']);
  }
}
