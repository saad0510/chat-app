class ChatException implements Exception {
  final String code;
  final String message;

  ChatException({required this.code, required this.message});

  ChatException.empty([this.message = ""]) : code = "";

  ChatException.unknown([this.message = "real-time database error"])
      : code = "unknown-error";

  ChatException.noUser([this.message = "no user found in given device"])
      : code = "no-user";

  ChatException.noKey([this.message = "no child key at given ref"])
      : code = "no-key";

  ChatException.noChatroom([this.message = "no chatroom at given ref"])
      : code = "no-chat";

  ChatException.noMsg([this.message = "no message at given ref"]) : code = "no-msg";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatException && other.code == code && other.message == message;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode;
}
