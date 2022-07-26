import 'dart:convert';

class ChatroomModel {
  final String crid;
  final List<String> userIds;
  final int timestamp;

  ChatroomModel({
    required this.crid,
    required this.userIds,
    required this.timestamp,
  });

  ChatroomModel copyWith({
    String? crid,
    List<String>? userIds,
    int? timestamp,
  }) {
    return ChatroomModel(
      crid: crid ?? this.crid,
      userIds: userIds ?? this.userIds,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'crid': crid,
      'users': Map<String, bool>.fromIterable(userIds, value: (_) => true),
      'timestamp': timestamp,
    };
  }

  factory ChatroomModel.fromMap(Map<String, dynamic> map) {
    return ChatroomModel(
      crid: map['crid'] as String,
      userIds: [for (final uid in (map["users"] as Map).keys) uid],
      timestamp: map['timestamp'] as int,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ChatroomModel.fromJson(String source) {
    return ChatroomModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return 'ChatRoomModel(crid: $crid, users: $userIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatroomModel &&
        other.crid == crid &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return crid.hashCode ^ timestamp.hashCode;
  }
}
