class LoginUser {
  String email;
  String password;

  LoginUser ({
    required this.email,
    required this.password,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    // Check and print out the raw JSON for debugging
    print('Parsing product JSON: $json');

    // Parse the JSON data, ensuring non-null fields are properly handled
    return LoginUser(
      email: json["email"] ?? '', // Use a default empty string if null
      password: json["password"] ?? '', // Use a default empty string if null
    );
  } 

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };

  // Method to check if the required fields are valid
  bool isValid() {
    return email.isNotEmpty && password.isNotEmpty;
  }


}
