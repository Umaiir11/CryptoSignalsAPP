class UserData {
  final User? user;  // Nullable user field
  final String? token;  // Nullable token field

  UserData({
    this.user,  // Nullable parameter
    this.token,  // Nullable parameter
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'token': token,
    };
  }
}


class User {
  final int? id;  // Nullable field
  final String? name;  // Nullable field
  final String? email;  // Nullable field
  final String? number;  // Nullable field
  final String? role;  // Nullable field
  final int? isNotifications;  // Nullable field
  final String? profilePic;  // Nullable field
  final int? status;  // Nullable field
  final dynamic subscription;  // Nullable field

  User({
    this.id,  // Nullable parameter
    this.name,  // Nullable parameter
    this.email,  // Nullable parameter
    this.number,  // Nullable parameter
    this.role,  // Nullable parameter
    this.isNotifications,  // Nullable parameter
    this.profilePic,  // Nullable parameter
    this.status,  // Nullable parameter
    this.subscription,  // Nullable parameter
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      number: json['number'],
      role: json['role'],
      isNotifications: json['is_notifications'],
      profilePic: json['profile_pic'],
      status: json['status'],
      subscription: json['subscription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'role': role,
      'is_notifications': isNotifications,
      'profile_pic': profilePic,
      'status': status,
      'subscription': subscription,
    };
  }
}
