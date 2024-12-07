import 'package:mongo_dart/mongo_dart.dart';
import '../models/LoginUser.dart';
import '../models/User.dart';
import 'mongodb.dart';
import 'package:bcrypt/bcrypt.dart';

class UserResp {
  final String username;
  final String email;

  UserResp(this.username, this.email);

  factory UserResp.fromJson(Map<String, dynamic> json) {
    return UserResp(
      json['username'] ?? '',
      json['email'] ?? '',
    );
  }
}
class LoginResponse {
  final UserResp? user;
  final String message;
  final bool success;

  LoginResponse(this.user, this.message, this.success);
  
}

// Create User
Future<void> createUser(User user) async {
  if (!user.isValid()) {
    print('Invalid user data. Ensure all fields are provided.');
    return;
  }

  print('User Data: ${user.toJson()}');
  try {
    // Hash the user's password
    final hashedPassword = BCrypt.hashpw(user.password, BCrypt.gensalt());
    user.password = hashedPassword as String;
    // Insert the user into MongoDB
    await MongoDatabase.userCollection.insert(user.toJson());
    print('User created successfully');
  } catch (e) {
    print('Failed to create user: $e');
  }
}

// Login User 
// Future<String> loginUser(LoginUser loginUser) async {
//   if (!loginUser.isValid()) {
//     return 'Invalid login data. Ensure all fields are provided.';
    
//   }

//   print('Login Data: ${loginUser.toJson()}');
//   try {
//     // Fetch the user from MongoDB
//     final user = await MongoDatabase.userCollection.findOne(where.eq('email', loginUser.email));
//     if (user == null) {
//       return 'User not found';
//     }

//     // Check if the password matches
//     final isValidPassword = BCrypt.checkpw(loginUser.password, user['password']);
//     if (!isValidPassword) {
//       return 'Invalid password';
//     }
//     return ('Welcome');
//   } catch (e) {
//     return 'Failed to login: ';
//   }
// }

Future<LoginResponse> loginUser(LoginUser loginUser) async {
  if (!loginUser.isValid()) {
    return LoginResponse(null, 'Invalid login data. Ensure all fields are provided.', false);
  }

  print('Login Data: ${loginUser.toJson()}');
  try {
    // Fetch the user from MongoDB
    final user = await MongoDatabase.userCollection.findOne(where.eq('email', loginUser.email));
    if (user == null) {
      return LoginResponse(null, 'User not found', false);
    }

    // Check if the password matches
    final isValidPassword = BCrypt.checkpw(loginUser.password, user['password']);
    if (!isValidPassword) {
      return LoginResponse(null, 'Invalid password', false);
    }
    return LoginResponse(UserResp.fromJson(user), 'Welcome', true);
  } catch (e) {
    return LoginResponse(null, 'Failed to login: $e', false);
  }
}