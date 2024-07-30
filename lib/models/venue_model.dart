// class Venue {
//   final int venueId;
//   final String venueName;
//   final String address;
//   final String openTime;
//   final String closedTime;
//   final String currTime;
//   final String category;
//   final double latitude;
//   final double longitude;
//   final String? city;
//   final String subTitle;
//   final String venueType;
//   final String imageUrl;
//
//   Venue({
//     required this.venueId,
//     required this.venueName,
//     required this.address,
//     required this.openTime,
//     required this.closedTime,
//     required this.currTime,
//     required this.category,
//     required this.latitude,
//     required this.longitude,
//     this.city,
//     required this.subTitle,
//     required this.venueType,
//     required this.imageUrl,
//   });
//
//   factory Venue.fromJson(Map<String, dynamic> json) {
//     return Venue(
//       venueId: json['venueId'],
//       venueName: json['venueName'],
//       address: json['address'],
//       openTime: json['openTime'],
//       closedTime: json['closedTime'],
//       currTime: json['currTime'],
//       category: json['category'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       city: json['city'],
//       subTitle: json['subTitle'] ?? 'Default Subtitle',
//       venueType: json['venueType'] ?? 'Default Venue Type',
//       imageUrl: json['imageUrl'] ?? 'https://example.com/default-image.jpg',
//     );
//   }
// }

class Venue {
  final String name;
  final String address;
  final bool openNow;
  //final String imageUrl;
  final String placeId;
  final List<String> openingTimes;
  final List<String> closingTimes;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;

  Venue({
    required this.name,
    required this.address,
    required this.openNow,
   // required this.imageUrl,
    required this.placeId,
    required this.openingTimes,
    required this.closingTimes,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
  });

  factory Venue.fromJson(Map<String, dynamic> json,  List<String> imageUrls) {
    List<String> openingTimes = List.filled(7, '');
    List<String> closingTimes = List.filled(7, '');

    if (json['opening_hours'] != null && json['opening_hours']['periods'] != null) {
      for (var period in json['opening_hours']['periods']) {
        int day = period['open']['day'];
        String openTime = period['open']['time'] ?? '0000';
        String closeTime = period['close'] != null ? period['close']['time'] : '';
        openingTimes[day] = openTime;
        closingTimes[day] = closeTime;
      }
    }

    return Venue(
      name: json['name'],
      address: json['vicinity'],
      openNow: json['opening_hours'] != null ? json['opening_hours']['open_now'] : false,
      imageUrls: imageUrls,
      placeId: json['place_id'],
      openingTimes: openingTimes,
      closingTimes: closingTimes,
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
    );
  }
}
