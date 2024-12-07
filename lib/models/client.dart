import 'package:mongo_dart/mongo_dart.dart';

class Product {
  ObjectId mongoId; // MongoDB _id field
  String id; // User-entered product ID
  String designation;

  Product({
    required this.mongoId,
    required this.id,
    required this.designation,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Check and print out the raw JSON for debugging
    print('Parsing product JSON: $json');

    // Parse the JSON data, ensuring non-null fields are properly handled
    return Product(
      mongoId: json["_id"] as ObjectId,
      id: json["id"] ?? '', // Use a default empty string if null
      designation: json["designation"] ?? '', // Use a default empty string if null
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": mongoId, // MongoDB _id field
        "id": id, // User-entered ID
        "designation": designation,
      };

  // Method to check if the required fields are valid
  bool isValid() {
    return id.isNotEmpty && designation.isNotEmpty;
  }
}
