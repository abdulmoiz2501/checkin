class VenueMarker {
  final String placeId;
  final int totalCheckIns;

  VenueMarker({
    required this.placeId,
    required this.totalCheckIns,
  });

  factory VenueMarker.fromJson(Map<String, dynamic> json) {
    return VenueMarker(
      placeId: json['placeId'],
      totalCheckIns: json['totalCheckIns'],
    );
  }
}
