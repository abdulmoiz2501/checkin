class ViewProfileModel {
  final bool status;
  final String message;
  final UserM user;

  ViewProfileModel(
      {required this.status, required this.message, required this.user});

  factory ViewProfileModel.fromJson(Map<String, dynamic> json) {
    return ViewProfileModel(
      status: json['status'],
      message: json['message'],
      user: UserM.fromJson(json['user']),
    );
  }
}

class UserM {
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
  final double? height;
  final int age;
  final bool subscribed;
  final bool showSexualOrientation;
  final List<UserPicture> userPictures;
  final List<String>? checkInGoals;

  UserM({
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
    required this.height,
    required this.age,
    required this.subscribed,
    required this.userPictures,
    this.checkInGoals,
  });

  factory UserM.fromJson(Map<String, dynamic> json) {
    var list = json['UserPictures'] as List;
    print("????????????????");
    print(json);
    double? h =
        json['height'] != null ? double.parse(json['height'].toString()) : null;
    List<UserPicture> userPictureList =
        list.map((i) => UserPicture.fromJson(i)).toList();
    print('id: ${json['id'].runtimeType}');
    print('uid: ${json['UId'].runtimeType}');
    print('name: ${json['name'].runtimeType}');
    print('number: ${json['number'].runtimeType}');
    print('description: ${json['description'].runtimeType}');
    print('gender: ${json['gender'].runtimeType}');
    print('sex: ${json['sex'].runtimeType}');
    print('activeStatus: ${json['activeStatus'].runtimeType}');
    print('packageId: ${json['packageId'].runtimeType}');
    print('date: ${json['date'].runtimeType}');
    print('email: ${json['email'].runtimeType}');
    print('height: ${json['height'].runtimeType}');
    print('age: ${json['age'].runtimeType}');
    print('subscribed: ${json['subscribed'].runtimeType}');

    return UserM(
      id: json['id'],
      showSexualOrientation: json['showSexualOrientation'],
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
      height: h,
      age: json['age'],
      subscribed: json['subscribed'],
      userPictures: userPictureList,
      checkInGoals: json['CheckInGoals'] != null
          ? List<String>.from(json['CheckInGoals'])
          : null,
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
