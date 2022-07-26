import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String image;
  final int timestamp;
  final bool withGoogle;
  final bool verfied;

  UserModel.only({
    this.uid = "",
    this.name = "",
    this.email = "",
    this.password = "",
    this.image = "",
    this.timestamp = -1,
    this.withGoogle = false,
    this.verfied = false,
  });

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.timestamp,
    required this.withGoogle,
    required this.verfied,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    String? image,
    int? timestamp,
    bool? withGoogle,
    bool? verfied,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
      timestamp: timestamp ?? this.timestamp,
      withGoogle: withGoogle ?? this.withGoogle,
      verfied: verfied ?? this.verfied,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'timestamp': timestamp,
      'withGoogle': withGoogle,
      'verfied': verfied,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      image: map['image'] as String,
      timestamp: map['timestamp'] as int,
      withGoogle: map['withGoogle'] as bool,
      verfied: map['verfied'] as bool,
    );
  }

  factory UserModel.fromAuthUser(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
      password: "",
      image: user.photoURL ?? "",
      timestamp: DateTime.now().millisecondsSinceEpoch,
      withGoogle: true,
      verfied: false,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, withGoogle: $withGoogle)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.image == image &&
        other.timestamp == timestamp &&
        other.withGoogle == withGoogle &&
        other.verfied == verfied;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        image.hashCode ^
        timestamp.hashCode ^
        withGoogle.hashCode ^
        verfied.hashCode;
  }
}
