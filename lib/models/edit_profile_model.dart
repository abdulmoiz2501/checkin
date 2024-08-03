class EditProfileModel {
  String gender;
  String sex;
  double height;
  String description;
  List<String>? localImages;
  List<String>? serverImageUrls;

  EditProfileModel({
    required this.gender,
    required this.sex,
    required this.height,
    required this.description,
    this.localImages,
    this.serverImageUrls,
  });

  Map<String, String> toJson() {
    print('to json called');
    final x = serverImageUrls?.join(',');
    print(x.runtimeType);
    return {
      'gender': gender,
      'sex': sex,
      'height': height != null ? height.toString() : '',
      'description': description,
      'imagesToKeep': serverImageUrls?.join(',') ?? '',
      // Add other fields as necessary
    };
  }
}
