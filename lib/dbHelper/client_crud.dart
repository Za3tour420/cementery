import 'package:mongo_dart/mongo_dart.dart';
import '../models/client.dart';
import 'mongodb.dart';

// Create Client
Future<void> createClient(Client client) async {
  if (!client.isValid()) {
    print('Invalid client data. Ensure all required fields are provided.');
    return;
  }
  
  print('Client Data: ${client.toJson()}');
  try {
    // Insert the client into MongoDB
    await MongoDatabase.clientCollection.insert(client.toJson());
    print('Client created successfully');
  } catch (e) {
    print('Failed to create client: $e');
  }
}

// Get all Clients
Future<List<Client>> getAllClients() async {
  try {
    // Fetch all clients and map them to Client objects
    final result = await MongoDatabase.clientCollection.find().toList();
    
    // Print the raw result for debugging
    print('Raw clients fetched: $result');

    return result
        .map((doc) => Client.fromJson(Map<String, dynamic>.from(doc))) // Convert the document into a Client model
        .toList();
  } catch (e) {
    print('Failed to fetch clients: $e');
    return [];
  }
}

// Update Client
Future<void> updateClient(Client client) async {
  if (!client.isValid()) {
    print('Invalid client data. Ensure all required fields are provided.');
    return;
  }

  try {
    final existingClient = await MongoDatabase.clientCollection.findOne(where.id(client.mongoId));
    if (existingClient == null) {
      print('Client not found for update');
      return;
    }

    // Proceed with the update if the client exists
    await MongoDatabase.clientCollection.update(
      where.id(client.mongoId), // Ensure you're querying by the correct ObjectId
      modify.set('type', client.type)
            .set('responsable', client.responsable)
            .set('telephone', client.telephone)
            .set('gouvernorat', client.gouvernorat)
            .set('delegation', client.delegation)
            .set('adresse', client.adresse)
            .set('email', client.email)
            .set('cimenterie', client.cimenterie)
            .set('produits', client.produits)
            .set('prix', client.prix),
    );
    print('Client updated successfully');
  } catch (e) {
    print('Failed to update client: $e');
  }
}

// Delete Client
Future<void> deleteClient(ObjectId mongoId) async {
  try {
    final existingClient = await MongoDatabase.clientCollection.findOne(where.id(mongoId));
    if (existingClient == null) {
      print('Client not found for deletion');
      return;
    }

    await MongoDatabase.clientCollection.remove(where.id(mongoId));
    print('Client deleted successfully');
  } catch (e) {
    print('Failed to delete client: $e');
  }
}
