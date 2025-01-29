import 'dart:io';

class UpdateBodyModel {
  String? name;
  File? profileImage;

  UpdateBodyModel({
    this.name,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile_pic': profileImage?.path,
    };
  }

}
