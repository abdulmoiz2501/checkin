class RejectRequestModel {
  final String userId;
  final String senderId;

  RejectRequestModel({required this.userId, required this.senderId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'senderId': senderId,
    };
  }
}
