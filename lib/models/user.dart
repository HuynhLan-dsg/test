class User {
  int? id;
  String username;
  String password;
  String fullname;
  String? email;
  String? avatar;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.fullname,
    this.email,
    this.avatar,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,

      "username": username,

      "password": password,

      "fullname": fullname,

      "email": email,

      "avatar": avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],

      username: map["username"],

      password: map["password"],

      fullname: map["fullname"],

      email: map["email"],

      avatar: map["avatar"],
    );
  }
}
