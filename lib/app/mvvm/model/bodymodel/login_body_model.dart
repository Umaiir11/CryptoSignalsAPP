class LoginBodyModel {
  String? number;
  String? password;

  LoginBodyModel({
    this.number,
    this.password,
  });

  // Convert the model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'password': password,
    };
  }

  // Optional: Factory constructor if you want to create it from JSON (not usually needed for body models)
  factory LoginBodyModel.fromJson(Map<String, dynamic> json) {
    return LoginBodyModel(
      number: json['number'],
      password: json['password'],
    );
  }
}
