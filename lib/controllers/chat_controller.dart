import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/rtdm_exception.dart';
import '../models/chatroom_model.dart';
import '../services/chat_service.dart';

class ChatController extends StateNotifier<ChatroomModel?> {
  final ChatService _chatService;
  final String uid;

  ChatController(this._chatService, {required this.uid}) : super(null);

  String get crid {
    if (state == null) {
      throw ChatException.noChatroom(
        "ChatController.crid: chatroom does not exist in given context",
      );
    }
    return state!.crid;
  }

  Future<void> startChatWith(String friendUid) async {
    state = null;
    if (uid.isEmpty) {
      throw ChatException.noUser(
        "ChatController.startChatWith($friendUid): no user found",
      );
    }
    final chatroom = await _chatService.startChatWith(uid, friendUid);
    state = chatroom;
  }

  Future<void> sendMessage(String friendUid, String text) async {
    await _chatService.sendMsg(crid, uid, friendUid, text);
  }
}
