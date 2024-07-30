import 'dart:convert';

import 'package:checkin/utils/formatters/formatter.dart';

class SingleChat {
  final String id;
  final String fromUser;
  final String toUser;
  final String message;
  final String timestamp;
  final bool isSeen;

  SingleChat({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.message,
    required this.timestamp,
    this.isSeen = true,
  });

  factory SingleChat.fromJson(Map<String, dynamic> json) {
    return SingleChat(
      id: json['messageId'],
      fromUser: json['senderId'].toString(),
      toUser: json['recieverId'].toString(),
      message: json['text'],
      timestamp: json['timeSent'],
      isSeen: json['is_seen'] ?? true,
    );
  }

  SingleChat copyWith({
    String? id,
    String? fromUser,
    String? toUser,
    String? message,
    String? timestamp,
    bool? isSeen,
  }) {
    return SingleChat(
      id: id ?? this.id,
      fromUser: fromUser ?? this.fromUser,
      toUser: toUser ?? this.toUser,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fromUser': fromUser,
      'toUser': toUser,
      'message': message,
      'timestamp': timestamp,
      'isSeen': isSeen,
    };
  }

  factory SingleChat.fromMap(Map<String, dynamic> map) {
    return SingleChat(
      id: map['messageId'] as String,
      fromUser: map['senderId'] as String,
      toUser: map['recieverId'] as String,
      message: map['text'] as String,
      timestamp: VoidFormatter.formatFirestoreTimestamp(map['timeSent']),
      isSeen: map['isSeen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SingleChat(id: $id, fromUser: $fromUser, toUser: $toUser, message: $message, timestamp: $timestamp, isSeen: $isSeen)';
  }

  @override
  bool operator ==(covariant SingleChat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fromUser == fromUser &&
        other.toUser == toUser &&
        other.message == message &&
        other.timestamp == timestamp &&
        other.isSeen == isSeen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    fromUser.hashCode ^
    toUser.hashCode ^
    message.hashCode ^
    timestamp.hashCode ^
    isSeen.hashCode;
    }
}