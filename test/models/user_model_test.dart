import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/user_model.dart';

void main() {
  late UserModel user;

  setUp(() {
    user = UserModel(
      uid: "uid",
      name: "name",
      email: "email",
      password: "password",
      image: "image",
      timestamp: 121,
      withGoogle: true,
      verfied: false,
    );
  });

  group("unnamed constructor:", () {
    test("setup", () {
      expect(user.uid, "uid");
      expect(user.name, "name");
      expect(user.email, "email");
      expect(user.password, "password");
      expect(user.image, "image");
      expect(user.timestamp, 121);
      expect(user.withGoogle, true);
      expect(user.verfied, false);
    });
    test("toMap()", () {
      Map<String, dynamic> map = user.toMap();

      expect(map["uid"], "uid");
      expect(map["name"], "name");
      expect(map["email"], "email");
      expect(map["password"], "password");
      expect(map["image"], "image");
      expect(map["timestamp"], 121);
      expect(map["withGoogle"], true);
      expect(map["verfied"], false);
    });
    test("fromMap()", () {
      user = UserModel.fromMap(user.toMap());
      expect(user.uid, "uid");
      expect(user.name, "name");
      expect(user.email, "email");
      expect(user.password, "password");
      expect(user.image, "image");
      expect(user.timestamp, 121);
      expect(user.withGoogle, true);
      expect(user.verfied, false);
    });
  });
}
