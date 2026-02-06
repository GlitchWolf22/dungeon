enum MessageType {
  system,
  player,
  gm, // Game Master / Narrator
}

class ChatMessage {
  final String sender;
  final String text;
  final MessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.type,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ChatMessage.system(String text) {
    return ChatMessage(sender: "System", text: text, type: MessageType.system);
  }

  factory ChatMessage.player(String sender, String text) {
    return ChatMessage(sender: sender, text: text, type: MessageType.player);
  }

  factory ChatMessage.gm(String text) {
    return ChatMessage(sender: "GM", text: text, type: MessageType.gm);
  }
}
