import 'package:mongo_dart/mongo_dart.dart';
import '../models/visite.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection visiteCollection;

  static Future<void> connect() async {
    db = await Db.create('mongodb://your_mongo_db_url');
    await db.open();
    visiteCollection = db.collection('visites');
  }

  static Future<void> createVisite(Visite visite) async {
    if (!visite.isValid()) {
      print('Invalid visite data. Ensure all fields are provided.');
      return;
    }

    print('Visite Data: ${visite.toJson()}');
    try {
      await visiteCollection.insert(visite.toJson());
      print('Visite created successfully');
    } catch (e) {
      print('Failed to create visite: $e');
    }
  }

  static Future<List<Visite>> getVisites() async {
    try {
      final visites = await visiteCollection.find().toList();
      return visites.map((json) => Visite.fromJson(json)).toList();
    } catch (e) {
      print('Failed to fetch visites: $e');
      return [];
    }
  }

  static Future<void> updateVisite(Visite visite) async {
    try {
      await visiteCollection.update(
        where.eq('date', visite.date.toIso8601String()),
        visite.toJson(),
      );
      print('Visite updated successfully');
    } catch (e) {
      print('Failed to update visite: $e');
    }
  }

  static Future<void> deleteVisite(DateTime date) async {
    try {
      await visiteCollection.remove(where.eq('date', date.toIso8601String()));
      print('Visite deleted successfully');
    } catch (e) {
      print('Failed to delete visite: $e');
    }
  }
}