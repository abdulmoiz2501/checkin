class ReportUserModel {
  final String userUID;
  final String reportUserUID;
  final String reason;

  ReportUserModel({required this.userUID, required this.reportUserUID, required this.reason});

  Map<String, String> toJson() {
    return {
      'userUID': userUID,
      'reportUserUID': reportUserUID,
      'reason': reason,
    };
  }
}
