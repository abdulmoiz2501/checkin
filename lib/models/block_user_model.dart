class BlockUserModel {
  final String userUID;
  final String blockUID;

  BlockUserModel({required this.userUID, required this.blockUID});

  Map<String, dynamic> toJson() {
    return {
      'userUID': userUID,
      'blockUID': blockUID,
    };
  }
}
