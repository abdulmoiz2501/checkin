class CheckOutRequest {
  final String userId;
  final String placeId;

  CheckOutRequest({required this.userId, required this.placeId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'placeId': placeId,
    };
  }
}
