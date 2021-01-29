enum UserType { consumer, vendor }

class User {
  User({this.username, this.password, this.email, this.userType});
  final String username, password, email;
  final UserType userType;

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        email = json['email'],
        userType = json['userType'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'userType': userType
      };
}
