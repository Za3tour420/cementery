import 'package:mongo_dart/mongo_dart.dart';
import '../models/LoginUser.dart';
import '../models/User.dart';
import 'mongodb.dart';
import 'package:bcrypt/bcrypt.dart';

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
Future<String> loginUser(LoginUser loginUser) async {
  if (!loginUser.isValid()) {
    return 'Invalid login data. Ensure all fields are provided.';
    
  }

  print('Login Data: ${loginUser.toJson()}');
  try {
    // Fetch the user from MongoDB
    final user = await MongoDatabase.userCollection.findOne(where.eq('email', loginUser.email));
    if (user == null) {
      return 'User not found';
    }

    // Check if the password matches
    final isValidPassword = BCrypt.checkpw(loginUser.password, user['password']);
    if (!isValidPassword) {
      return 'Invalid password';
    }

    return ('Welcome');
  } catch (e) {
    return 'Failed to login: ';
  }
}