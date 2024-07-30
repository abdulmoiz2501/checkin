class DummyData {
  static List<Map<String, String>> venues = [
    {
      "venueId": "1",
      "venueName": "Marble Bar",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Bar",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "2",
      "venueName": "Art House Hotel",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Bar",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "3",
      "venueName": "The Dolphin Hotel",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Bar",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "4",
      "venueName": "Forrester's Pub",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Cafe",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "5",
      "venueName": "Forrester's Pub",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Cafe",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "6",
      "venueName": "Forrester's Pub",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Cafe",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "7",
      "venueName": "Forrester's Pub",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Cafe",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "8",
      "venueName": "Local Museum",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Museum",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "9",
      "venueName": "City Museum",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Museum",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "10",
      "venueName": "Fine Dining",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Restaurants",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
    {
      "venueId": "11",
      "venueName": "Family Restaurant",
      "subtitle": "Pub",
      "address": "123 ABC Street, City",
      "category": "Restaurants",
      "mainImage": "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg",
    },
  ];

  static List<Map<String, String>> getHomeScreenData() {
    return venues.map((venue) {
      return {
        'image': venue['mainImage']!,
        'title': venue['venueName']!,
      };
    }).toList();
  }
}
