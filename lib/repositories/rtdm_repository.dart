import 'package:firebase_database/firebase_database.dart';

import '../../errors/rtdm_exception.dart';
import '../models/chatroom_model.dart';
import '../models/text_message_model.dart';
import 'base/base_rtdm_repository.dart';

class RealTimeDatabaseRepository extends BaseRealTimeDatabaseRepository {
  final FirebaseDatabase _rtdm;

  static const chatroomInfoPath = "/chatrooms_info";
  static const chatroomsPath = "/chatrooms";
  static const usersPath = "/users";
  static const messagesPath = "/messages";
  static const lastMsgPath = "/last_msg";

  RealTimeDatabaseRepository(this._rtdm);

  @override
  Future<void> createChatroom(ChatroomModel chatroom) async {
    bool chatExists = await chatroomExists(chatroom.crid);
    if (chatExists) return;

    await addFriends(
      chatroom.userIds[0],
      chatroom.userIds[1],
      chatroom.crid,
    );
    await createChatroomInfo(chatroom);
    await createLastTextMessage(chatroom.crid, "");
  }

  @override
  Future<void> createChatroomInfo(ChatroomModel chatroom) async {
    final chatroomInfoRef = refTo("/$chatroomInfoPath/${chatroom.crid}");
    await chatroomInfoRef.set(chatroom.toMap());
  }

  @override
  Future<void> createTextMessage(TextMessageModel message) async {
    final msgRef = refTo("/$messagesPath/${message.mid}");
    await msgRef.set(message.toMap());

    final chatroomInfoRef = refTo("/$chatroomInfoPath/${message.crid}");
    await chatroomInfoRef.update({lastMsgPath: message.mid});

    final chatroomRef = refTo("/$chatroomsPath");
    await chatroomRef.update(
      {"${message.crid}/${message.mid}": true},
    );
    createLastTextMessage(message.crid, message.mid);
  }

  @override
  Future<void> createLastTextMessage(String crid, String mid) async {
    final lastMsgRef = refTo("/$lastMsgPath/");
    await lastMsgRef.update({crid: mid});
  }

  @override
  Future<bool> chatroomExists(String crid) async {
    final chatroomInfoRef = refTo("/$chatroomInfoPath/$crid");
    return (await chatroomInfoRef.get()).exists;
  }

  @override
  Future<void> addFriends(String uid1, String uid2, String crid) async {
    final usersRef = refTo("/$usersPath");

    await usersRef.update({
      "$uid1/$uid2": crid,
      "$uid2/$uid1": crid,
    });
  }

  @override
  Future<Map<String, String>?> getFriends(String uid) async {
    final userRef = refTo("/$usersPath/$uid");
    final doc = await userRef.get();

    if (doc.exists == false) return null;
    return doc.value as Map<String, String>;
  }

  @override
  Future<String?> getCridOf(String uid, String friendUid) async {
    final userRef = refTo("/$usersPath/$uid");
    final doc = await userRef.get();
    if (doc.exists == false) return null;

    final value = doc.value as Map;
    if (value.containsKey(friendUid)) {
      return value[friendUid];
    }
    return null;
  }

  @override
  Future<ChatroomModel?> getChatroomInfo(String crid) async {
    final chatroomInfoRef = refTo("/$chatroomInfoPath");
    final doc = await chatroomInfoRef.child("/$crid").get();

    if (doc.value == null) return null;
    return ChatroomModel.fromMap(
      doc.value as Map<String, dynamic>,
    );
  }

  @override
  Future<TextMessageModel?> getTextMessage(String mid) async {
    final msgRef = refTo("/$messagesPath/$mid");
    final doc = await msgRef.get();
    if (doc.exists) {
      return TextMessageModel.fromMap(doc.value as Map);
    }
    return null;
  }

  @override
  Future<TextMessageModel?> getLastTextMessage(String crid) async {
    final lastMsgInfo = refTo("/$lastMsgPath/$crid");
    final doc = await lastMsgInfo.get();
    if (doc.exists == false) return null;
    return await getTextMessage(doc.value as String);
  }

  @override
  Stream<String> listenLastTextMessage(String crid) {
    return refTo("/$lastMsgPath/$crid").onValue.map(
      (event) {
        final doc = event.snapshot.value;
        if (doc == null) return "";
        return doc as String;
      },
    );
  }

  @override
  Stream<List<TextMessageModel>?> listenChatroom(String crid) {
    final chatRef = refTo("/$chatroomsPath/$crid");
    return chatRef.onValue.asyncMap<List<TextMessageModel>?>(
      (event) async {
        final map = event.snapshot.value;
        if (map == null) return null;

        final mids = (map as Map).keys;
        return Future.wait(
          mids.map<Future<TextMessageModel>>(
            (mid) async {
              final msg = await getTextMessage(mid);
              if (msg == null) {
                throw ChatException.noMsg(
                    "RealTimeDatabaseRepository.listenChatroom: no msg for mid $mid");
              }
              return msg;
            },
          ),
        );
      },
    );
  }

  @override
  Stream<Map?> listenFriends(String uid) {
    final chatRef = refTo("/$usersPath/$uid");
    return chatRef.onValue.map<Map?>(
      (event) {
        final map = event.snapshot.value;
        if (map == null) return null;
        return map as Map;
      },
    );
  }

  DatabaseReference refTo(String path) => _rtdm.ref(path);

  @override
  String get uniqueCrid => addChildAt("/$chatroomInfoPath");

  @override
  String get uniqueMid => addChildAt("/$messagesPath");

  String addChildAt(String path) {
    String? key = refTo(path).push().key;
    if (key != null) return key;

    throw ChatException.noKey(
      "RealTimeDatabaseRepository.uniqueCrid: unable to get key",
    );
  }
}
