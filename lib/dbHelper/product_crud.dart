import 'package:mongo_dart/mongo_dart.dart';
import '../models/product.dart';
import 'mongodb.dart';

// Create Product
Future<void> createProduct(Product product) async {
  if (!product.isValid()) {
    print('Invalid product data. Ensure both ID and designation are provided.');
    return;
  }
  
  print('Product Data: ${product.toJson()}');
  try {
    // Insert the product into MongoDB
    await MongoDatabase.productCollection.insert(product.toJson());
    print('Product created successfully');
  } catch (e) {
    print('Failed to create product: $e');
  }
}

// Get all Products
Future<List<Product>> getAllProducts() async {
  try {
    // Fetch all products and map them to Product objects
    final result = await MongoDatabase.productCollection.find().toList();
    
    // Print the raw result for debugging
    print('Raw products fetched: $result');

    return result
        .map((doc) => Product.fromJson(Map<String, dynamic>.from(doc))) // Convert the document into a Product model
        .toList();
  } catch (e) {
    print('Failed to fetch products: $e');
    return [];
  }
}

// Update Product
Future<void> updateProduct(Product product) async {
  if (!product.isValid()) {
    print('Invalid product data. Ensure both ID and designation are provided.');
    return;
  }

  try {
    final existingProduct = await MongoDatabase.productCollection.findOne(where.id(product.mongoId));
    if (existingProduct == null) {
      print('Product not found for update');
      return;
    }

    // Proceed with the update if the product exists
    await MongoDatabase.productCollection.update(
      where.id(product.mongoId), // Ensure you're querying by the correct ObjectId
      modify.set('designation', product.designation).set('id', product.id), // Update designation and id
    );
    print('Product updated successfully');
  } catch (e) {
    print('Failed to update product: $e');
  }
}

// Delete Product
Future<void> deleteProduct(ObjectId mongoId) async {
  try {
    final existingProduct = await MongoDatabase.productCollection.findOne(where.id(mongoId));
    if (existingProduct == null) {
      print('Product not found for deletion');
      return;
    }

    await MongoDatabase.productCollection.remove(where.id(mongoId));
    print('Product deleted successfully');
  } catch (e) {
    print('Failed to delete product: $e');
  }
}
