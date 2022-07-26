import 'dart:convert';

import '../utils/enums.dart';
import 'message_model.dart';

class TextMessageModel extends MessageModel {
  final String crid;
  final String content;

  TextMessageModel({
    required String mid,
    required String sender,
    required String receiver,
    required int timestamp,
    required bool sent,
    required bool received,
    required bool seen,
    required this.content,
    required this.crid,
  }) : super(
          mid: mid,
          sender: sender,
          receiver: receiver,
          timestamp: timestamp,
          sent: sent,
          received: received,
          seen: seen,
          type: MsgType.Text,
        );

  @override
  TextMessageModel copyWith({
    String? mid,
    String? sender,
    String? receiver,
    int? timestamp,
    bool? sent,
    bool? received,
    bool? seen,
    MsgType? type,
    String? content,
    String? crid,
  }) {
    return TextMessageModel(
      mid: mid ?? this.mid,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      timestamp: timestamp ?? this.timestamp,
      sent: sent ?? this.sent,
      received: received ?? this.received,
      seen: seen ?? this.seen,
      content: content ?? this.content,
      crid: crid ?? this.crid,
    );
  }

  @override
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
      'content': content,
      'crid': crid,
    };
  }

  factory TextMessageModel.fromMap(Map<dynamic, dynamic> map) {
    return TextMessageModel(
      mid: map['mid'] as String,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      timestamp: map['timestamp'] as int,
      sent: map['sent'] as bool,
      received: map['received'] as bool,
      seen: map['seen'] as bool,
      content: map['content'] as String,
      crid: map['crid'] as String,
    );
  }

  @override
  String toJson() {
    return json.encode(toMap());
  }

  factory TextMessageModel.fromJson(String source) {
    return TextMessageModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return 'TextMessageModel(content:$content sender: $sender, receiver: $receiver)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextMessageModel &&
        other.mid == mid &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.timestamp == timestamp &&
        other.sent == sent &&
        other.received == received &&
        other.seen == seen &&
        other.type == type &&
        other.content == content &&
        other.crid == crid;
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
        type.hashCode ^
        content.hashCode ^
        crid.hashCode;
  }
}
