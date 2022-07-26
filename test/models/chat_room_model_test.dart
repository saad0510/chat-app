import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/chatroom_model.dart';

void main() {
  late ChatroomModel chat;

  final uids = ["user1", "user2"];

  setUp(() {
    chat = ChatroomModel(
      crid: "crid",
      userIds: uids,
      lastMsg: "lastMsg",
      timestamp: 230008,
    );
  });

  group("unnamed constructor:", () {
    test("setup", () {
      expect(chat.crid, "crid");

      for (int i = 0; i < chat.userIds.length; i++) {
        expect(chat.userIds[i], uids[i]);
      }

      expect(chat.lastMsg, "lastMsg");
      expect(chat.timestamp, 230008);
    });

    test("toMap()", () {
      Map<String, dynamic> map = chat.toMap();
      expect(map["crid"], "crid");

      final userIds = (map["users"] as Map<String, bool>).keys.toList();
      for (int i = 0; i < userIds.length; i++) {
        expect(userIds[i], uids[i]);
      }

      expect(map["lastMsg"], "lastMsg");
      expect(map["timestamp"], 230008);
    });

    test("fromMap()", () {
      chat = ChatroomModel.fromMap(chat.toMap());
      expect(chat.crid, "crid");

      for (int i = 0; i < chat.userIds.length; i++) {
        expect(chat.userIds[i], uids[i]);
      }

      expect(chat.lastMsg, "lastMsg");
      expect(chat.timestamp, 230008);
    });

    test("toMap() display", () {
      debugPrint(chat.toMap().toString());
    });

    test("toString() display", () {
      debugPrint(chat.toString());
    });
  });
}
