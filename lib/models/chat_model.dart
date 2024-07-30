import 'user_model.dart';

class Chat {
  final UserModel user;
  final String message;
  final String timestamp;
  final bool isOnline;
  Chat({
    required this.isOnline,
    required this.user,
    required this.message,
    required this.timestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    print('the user is:${json['user']}');
    return Chat(
        user: UserModel.fromJson(json['user']),
        isOnline: true,
        message: json['message'],
        timestamp: json['timestamp'],
        );
  }
}