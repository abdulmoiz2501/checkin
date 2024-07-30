// models/send_request_model.dart
class SendRequestModel {
  final String senderUid;
  final String receiverUid;

  SendRequestModel({required this.senderUid, required this.receiverUid});

  Map<String, dynamic> toJson() {
    return {
      'senderUID': senderUid,
      'receiverUID': receiverUid,
    };
  }
}
