import 'package:mongo_dart/mongo_dart.dart';
import '../models/visit.dart';

class VisitCrud {
  final Db db;
  late final DbCollection visitCollection;

  VisitCrud(this.db) {
    visitCollection = db.collection('visits'); // The collection name in MongoDB
  }

  // Create a new Visit in the database
  // In visit_crud.dart
Future<void> createVisit(Visit visit) async {
  try {
    final result = await visitCollection.insertOne(visit.toMap());
    if (result.isSuccess) {
      print("Visit inserted successfully with _id: ${result.document?['_id']}");
    } else {
      print("Failed to insert visit.");
    }
  } catch (e) {
    print("Error inserting visit: $e");
  }
}


  // Retrieve all Visits from the database
  Future<List<Visit>> getAllVisits() async {
    try {
      final visitsMap = await visitCollection.find().toList();
      return visitsMap.map((visitMap) => Visit.fromMap(visitMap)).toList();
    } catch (e) {
      print("Error retrieving visits: $e");
      return [];
    }
  }

  // Retrieve a specific Visit by its _id
  Future<Visit?> getVisitById(ObjectId id) async {
    try {
      final visitMap = await visitCollection.findOne(where.eq('_id', id));
      if (visitMap != null) {
        return Visit.fromMap(visitMap);
      }
      return null;
    } catch (e) {
      print("Error retrieving visit by _id: $e");
      return null;
    }
  }

  // Update an existing Visit in the database
  Future<void> updateVisit(Visit visit) async {
    try {
      await visitCollection.updateOne(
        where.eq('_id', visit.mongoId),  // Use the ObjectId to find the document
        modify.set('date', visit.date.toIso8601String())
              .set('client', visit.client)
              .set('responsable', visit.responsable)
              .set('cimenterie', visit.cimenterie)
              .set('produit', visit.produit)
              .set('prix', visit.prix)
              .set('reclamation', visit.reclamation),
      );
      print("Visit updated successfully.");
    } catch (e) {
      print("Error updating visit: $e");
    }
  }

  // Delete a Visit by its _id
  Future<void> deleteVisit(ObjectId id) async {
    try {
      await visitCollection.deleteOne(where.eq('_id', id));
      print("Visit deleted successfully.");
    } catch (e) {
      print("Error deleting visit: $e");
    }
  }
}
