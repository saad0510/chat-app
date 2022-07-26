import '../errors/rtdm_exception.dart';
import '../models/chatroom_model.dart';
import '../models/text_message_model.dart';
import '../repositories/base/base_rtdm_repository.dart';

class ChatService {
  final BaseRealTimeDatabaseRepository _rtdmRepo;

  ChatService(this._rtdmRepo);

  Future<ChatroomModel> startChatWith(String uid, String friendUid) async {
    String? crid = await _rtdmRepo.getCridOf(uid, friendUid);
    final chatroom = ChatroomModel(
      crid: crid ?? _rtdmRepo.uniqueCrid,
      userIds: [uid, friendUid],
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    await _rtdmRepo.createChatroom(chatroom);
    return chatroom;
  }

  Future<TextMessageModel> sendMsg(
    String crid,
    String uid,
    String friendUid,
    String msg,
  ) async {
    final textmsg = TextMessageModel(
      crid: crid,
      mid: _rtdmRepo.uniqueMid,
      sender: uid,
      receiver: friendUid,
      sent: false,
      received: false,
      seen: false,
      content: msg,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    await _rtdmRepo.createTextMessage(textmsg);
    return textmsg;
  }

  Future<TextMessageModel?> getMessage(String mid) async {
    return await _rtdmRepo.getTextMessage(mid);
  }

  Future<ChatroomModel> getChatroom(String crid) async {
    final chatroom = await _rtdmRepo.getChatroomInfo(crid);
    if (chatroom == null) {
      throw ChatException.noChatroom(
        "ChatService.getChatroom($crid): chatroom does not exist",
      );
    }
    return chatroom;
  }
}
