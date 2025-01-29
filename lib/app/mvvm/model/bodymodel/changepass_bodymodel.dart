class ChangePassBodyModel {
  String? password;
  String? passwordConfirmation;

  String? oldPassword;

  ChangePassBodyModel({
    this.oldPassword,
    this.passwordConfirmation,
    this.password
  });

  // Convert the model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'password_confirmation': passwordConfirmation,
      'password': password,
    };
  }


}
