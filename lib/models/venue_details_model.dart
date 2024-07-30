// models/venue_details_model.dart
class VenueDetails {
  final bool status;
  final String message;
  final int totalPeopleCheckedIn;
  final Map<String, int> interests;

  VenueDetails({
    required this.status,
    required this.message,
    required this.totalPeopleCheckedIn,
    required this.interests,
  });

  factory VenueDetails.fromJson(Map<String, dynamic> json) {
    return VenueDetails(
      status: json['status'],
      message: json['message'],
      totalPeopleCheckedIn: json['totalPeopleCheckedIn'] ?? 0,
      interests: json['venue'] != null
          ? Map<String, int>.from(json['venue'].map((k, v) => MapEntry(k, v)))
          : {},
    );
  }
}
