class ViewProfileModel {
  final bool status;
  final String message;
  final User user;

  ViewProfileModel({required this.status, required this.message, required this.user});

  factory ViewProfileModel.fromJson(Map<String, dynamic> json) {
    return ViewProfileModel(
      status: json['status'],
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String uid;
  final String name;
  final int number;
  final String description;
  final String gender;
  final String sex;
  final String activeStatus;
  final int packageId;
  final String date;
  final String email;
  final int height;
  final int age;
  final bool subscribed;
  final List<UserPicture> userPictures;

  User({
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
    required this.height,
    required this.age,
    required this.subscribed,
    required this.userPictures,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['UserPictures'] as List;
    print("????????????????");
    print(json);
    List<UserPicture> userPictureList = list.map((i) => UserPicture.fromJson(i)).toList();

    return User(
      id: json['id'],
      uid: json['UId'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
      gender: json['gender'],
      sex: json['sex'],
      activeStatus: json['activeStatus'],
      packageId: json['packageId'],
      date: json['date'],
      email: json['email'],
      height: json['height'],
      age: json['age'],
      subscribed: json['subscribed'],
      userPictures: userPictureList,
    );
  }
}

class UserPicture {
  final int id;
  final int userId;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
