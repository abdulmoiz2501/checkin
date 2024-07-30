// get_request_models.dart

class UserPicture {
  final int id;
  final int userId;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserPicture({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPicture.fromJson(Map<String, dynamic> json) {
    return UserPicture(
      id: json['id'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Sender {
  final int id;
  final String uid;
  final String name;
  final int number;
  final String description;
  final String gender;
  final String sex;
  final String activeStatus;
  final int packageId;
  final DateTime date;
  final String email;
  final int age;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<UserPicture> userPictures;
  final bool? subscribed;

  Sender({
    required this.id,
    required this.uid,
    required this.name,
    required this.number,
    required this.description,
    required this.gender,
    required this.sex,
    required this.activeStatus,
    required this.packageId,
    required this.date,
    required this.email,
    required this.age,
    required this.createdAt,
    required this.updatedAt,
    required this.userPictures,
    this.subscribed,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      uid: json['UId'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      gender: json['gender'],
      sex: json['sex'],
      activeStatus: json['activeStatus'],
      packageId: json['packageId'],
      date: DateTime.parse(json['date']),
      email: json['email'],
      age: json['age'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userPictures: (json['UserPictures'] as List)
          .map((picture) => UserPicture.fromJson(picture))
          .toList(),
      subscribed: json['subscribed'],
    );
  }
}

class RecRequest {
  final int senderId;
  final int receiverId;
  final DateTime requestDate;
  final String requestStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Sender sender;

  RecRequest({
    required this.senderId,
    required this.receiverId,
    required this.requestDate,
    required this.requestStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.sender,
  });

  factory RecRequest.fromJson(Map<String, dynamic> json) {
    return RecRequest(
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      requestDate: DateTime.parse(json['request_date']),
      requestStatus: json['request_status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      sender: Sender.fromJson(json['Sender']),
    );
  }
}
