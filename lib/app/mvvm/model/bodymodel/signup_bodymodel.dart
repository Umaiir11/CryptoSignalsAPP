import 'dart:io';

class SignupBodyModel {
  String? name;
  String? email;
  String? number;
  String? password;
  String? passwordConfirmation;
  File? profileImage;

  SignupBodyModel({this.name, this.email, this.number, this.password, this.passwordConfirmation, this.profileImage});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'profile_pic': profileImage?.path,
    };
  }
}
