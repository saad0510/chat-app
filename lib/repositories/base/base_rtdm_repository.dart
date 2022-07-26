import '../../models/chatroom_model.dart';
import '../../models/text_message_model.dart';

abstract class BaseRealTimeDatabaseRepository {
  Future<void> createChatroom(ChatroomModel chatroom);
  Future<void> createChatroomInfo(ChatroomModel chatroom);
  Future<ChatroomModel?> getChatroomInfo(String crid);
  Future<String?> getCridOf(String uid, String friendUid);
  Stream<List<TextMessageModel>?> listenChatroom(String crid);
  Future<bool> chatroomExists(String crid);

  Future<void> createTextMessage(TextMessageModel message);
  Future<TextMessageModel?> getTextMessage(String mid);
  Future<void> createLastTextMessage(String crid, String mid);
  Future<TextMessageModel?> getLastTextMessage(String crid);
  Stream<String> listenLastTextMessage(String crid);

  Future<void> addFriends(String uid1, String uid2, String crid);
  Future<Map<String, String>?> getFriends(String uid);
  Stream<Map?> listenFriends(String uid);

  String get uniqueCrid;
  String get uniqueMid;
}
