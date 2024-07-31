
import 'dart:io';

class EditProfileModel {
  final String gender;
  final String sex;
  final double height;
  final String description;
  final List<String> images;

  EditProfileModel({
    required this.gender,
    required this.sex,
    required this.height,
    required this.description,
    required this.images,
  });

  Map<String, String> toJson() {
    return {
    'gender': gender,
    'sex': sex,
    'height': height.toString(),
    'description': description,
    };
    }
}