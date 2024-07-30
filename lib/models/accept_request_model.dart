class AcceptRequestModel {
  final String userId;
  final String senderId;

  AcceptRequestModel({required this.userId, required this.senderId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'senderId': senderId,
    };
  }
}
