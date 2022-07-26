import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/text_message_model.dart';
import 'package:todo/utils/enums.dart';

void main() {
  late TextMessageModel msg;

  setUp(() {
    msg = TextMessageModel(
      mid: "mid",
      sender: "sender",
      receiver: "receiver",
      timestamp: 19999,
      sent: true,
      received: true,
      seen: false,
      content: "this is content",
      crid: "saad",
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
      expect(msg.content, "this is content");
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
      expect(map["content"], "this is content");
    });

    test("fromMap()", () {
      msg = TextMessageModel.fromMap(msg.toMap());
      expect(msg.mid, "mid");
      expect(msg.sender, "sender");
      expect(msg.receiver, "receiver");
      expect(msg.timestamp, 19999);
      expect(msg.sent, true);
      expect(msg.received, true);
      expect(msg.seen, false);
      expect(msg.type, MsgType.Text);
      expect(msg.content, "this is content");
    });
  });
}
