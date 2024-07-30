// models/payment_model.dart

class PaymentModel {
  final String date;
  final double amount;
  final String reason;
  final String userId;
  final int voucherId;

  PaymentModel({
    required this.date,
    required this.amount,
    required this.reason,
    required this.userId,
    required this.voucherId,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
      'reason': reason,
      'userId': userId,
      'voucherId': voucherId,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      date: json['date'],
      amount: json['amount'],
      reason: json['reason'],
      userId: json['userId'],
      voucherId: json['voucherId'],
    );
  }
}
