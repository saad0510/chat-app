import 'dart:convert';

import '../utils/enums.dart';

class MessageModel {
  final String mid;
  final String sender;
  final String receiver;
  final int timestamp;
  bool sent;
  bool received;
  bool seen;
  MsgType type;

  MessageModel({
    required this.mid,
    required this.sender,
    required this.receiver,
    required this.timestamp,
    required this.sent,
    required this.received,
    required this.seen,
    required this.type,
  });

  MessageModel copyWith({
    String? mid,
    String? sender,
    String? receiver,
    int? timestamp,
    bool? sent,
    bool? received,
    bool? seen,
    MsgType? type,
  }) {
    return MessageModel(
      mid: mid ?? this.mid,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      timestamp: timestamp ?? this.timestamp,
      sent: sent ?? this.sent,
      received: received ?? this.received,
      seen: seen ?? this.seen,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mid': mid,
      'sender': sender,
      'receiver': receiver,
      'timestamp': timestamp,
      'sent': sent,
      'received': received,
      'seen': seen,
      'type': type.toStr(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    const temp = MsgType.Text;

    return MessageModel(
      mid: map['mid'] as String,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      timestamp: map['timestamp'] as int,
      sent: map['sent'] as bool,
      received: map['received'] as bool,
      seen: map['seen'] as bool,
      type: temp.fromStr(map["type"] as String),
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory MessageModel.fromJson(String source) {
    return MessageModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return 'MessageModel(sender: $sender, receiver: $receiver, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.mid == mid &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.timestamp == timestamp &&
        other.sent == sent &&
        other.received == received &&
        other.seen == seen &&
        other.type == type;
  }

  @override
  int get hashCode {
    return mid.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        timestamp.hashCode ^
        sent.hashCode ^
        received.hashCode ^
        seen.hashCode ^
        type.hashCode;
  }
}
