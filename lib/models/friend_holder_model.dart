import 'dart:convert';

import 'user_model.dart';

class FriendHolderModel {
  final String crid;
  final UserModel user;

  FriendHolderModel({
    required this.crid,
    required this.user,
  });

  FriendHolderModel copyWith({
    String? crid,
    UserModel? user,
  }) {
    return FriendHolderModel(
      crid: crid ?? this.crid,
      user: user ?? this.user,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      user.uid: crid,
    };
  }

  factory FriendHolderModel.fromMap(Map<String, String> map) {
    return FriendHolderModel(
      crid: map.keys.first,
      user: UserModel.only(uid: map.values.first),
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory FriendHolderModel.fromJson(String source) {
    return FriendHolderModel.fromMap(json.decode(source) as Map<String, String>);
  }

  @override
  String toString() => 'FriendHolderModel(crid: $crid, uid: ${user.uid})';

  @override
  bool operator ==(covariant FriendHolderModel other) {
    if (identical(this, other)) return true;
    return other.crid == crid && other.user == user;
  }

  @override
  int get hashCode => crid.hashCode ^ user.hashCode;
}
