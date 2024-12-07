import 'package:mongo_dart/mongo_dart.dart';



class User {
  String username;
  String email;
  String password;

  User({
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Check and print out the raw JSON for debugging
    print('Parsing product JSON: $json');

    // Parse the JSON data, ensuring non-null fields are properly handled
    return User(
      username: json["username"] ?? '', // Use a default empty string if null
      email: json["email"] ?? '', // Use a default empty string if null
      password: json["password"] ?? '', // Use a default empty string if null
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };

  // Method to check if the required fields are valid
  bool isValid() {
    return username.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }
}




