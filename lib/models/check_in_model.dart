class CheckInRequest {
  final String userId;
  final String placeId;
  final String category;
  final String venueName;
  final String? venueImage;

  CheckInRequest({
    required this.userId,
    required this.placeId,
    required this.category,
    required this.venueName,
    this.venueImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'placeId': placeId,
      'category': category,
      'venueName': venueName,
      'venueImage' : venueImage,
    };
  }
}

class CheckInResponse {
  final bool status;
  final String message;
  final Venue? venue;

  CheckInResponse({
    required this.status,
    required this.message,
    this.venue,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) {
    return CheckInResponse(
      status: json['status'],
      message: json['message'],
      venue: json['venue'] != null ? Venue.fromJson(json['venue']) : null,
    );
  }
}

class Venue {
  final int venueId;
  final String placeId;
  final int totalCheckIns;
  final Map<String, int> categoryCounts;

  Venue({
    required this.venueId,
    required this.placeId,
    required this.totalCheckIns,
    required this.categoryCounts,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      venueId: json['venueId'],
      placeId: json['placeId'],
      totalCheckIns: json['totalCheckIns'],
      categoryCounts: Map<String, int>.from(json['categoryCounts']),
    );
  }
}
