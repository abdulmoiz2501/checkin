class SubscriptionModel {
  final String userId;
  final int voucherId;

  SubscriptionModel({
    required this.userId,
    required this.voucherId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'voucherId': voucherId,
    };
  }
}
