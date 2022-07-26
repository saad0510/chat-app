import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/message_model.dart';
import 'package:todo/utils/enums.dart';

void main() {
  late MessageModel msg;

  setUp(() {
    msg = MessageModel(
      mid: "mid",
      sender: "sender",
      receiver: "receiver",
      timestamp: 19999,
      sent: true,
      received: true,
      seen: false,
      type: MsgType.Text,
    );
  });

  group("unnamed constructor:", () {
    test("setup", () {
      expect(msg.mid, "mid");
      expect(msg.sender, "sender");
      expect(msg.receiver, "receiver");
      expect(msg.timestamp, 19999);
      expect(msg.sent, true);
      expect(msg.received, true);
      expect(msg.seen, false);
      expect(msg.type, MsgType.Text);
    });
    test("toMap()", () {
      Map<String, dynamic> map = msg.toMap();
      const temp = MsgType.Pdf;

      expect(map["mid"], "mid");
      expect(map["sender"], "sender");
      expect(map["receiver"], "receiver");
      expect(map["timestamp"], 19999);
      expect(map["sent"], true);
      expect(map["received"], true);
      expect(map["seen"], false);
      expect(temp.fromStr(map["type"]), MsgType.Text);
    });
    test("fromMap()", () {
      msg = MessageModel.fromMap(msg.toMap());
      expect(msg.mid, "mid");
      expect(msg.sender, "sender");
      expect(msg.receiver, "receiver");
      expect(msg.timestamp, 19999);
      expect(msg.sent, true);
      expect(msg.received, true);
      expect(msg.seen, false);
      expect(msg.type, MsgType.Text);
    });
  });
}
