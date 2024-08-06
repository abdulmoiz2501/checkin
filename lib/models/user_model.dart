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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class UserModel {
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
  final bool showSexualOrientation;
  final DateTime updatedAt;
  final List<UserPicture> userPictures;
  final bool? subscribed;
  final List<String>? checkInGoals;

  UserModel({
    required this.showSexualOrientation,
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
    this.checkInGoals,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      uid: json['UId'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      gender: json['gender'],
      sex: json['sex'],
      activeStatus: json['activeStatus'],
      showSexualOrientation: json['showSexualOrientation'],
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
      checkInGoals: json['CheckInGoals'] != null
          ? List<String>.from(json['CheckInGoals'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'UId': uid,
      'name': name,
      'number': number,
      'description': description,
      'gender': gender,
      'sex': sex,
      'activeStatus': activeStatus,
      'packageId': packageId,
      'date': date.toIso8601String(),
      'email': email,
      'age': age,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'UserPictures': userPictures.map((picture) => picture.toJson()).toList(),
      'subscribed': subscribed,
      'CheckInGoals': checkInGoals,
    };
  }
}
