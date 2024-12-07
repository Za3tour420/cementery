import 'package:mongo_dart/mongo_dart.dart';  // Import the mongo_dart package

class Visit {
  ObjectId? mongoId;  // mongoId as ObjectId (nullable)
  DateTime date;
  String client;
  String responsable;
  String cimenterie;
  String produit;
  double prix;
  String reclamation;

  Visit({
    this.mongoId,  // _id is optional during creation
    required this.date,
    required this.client,
    required this.responsable,
    required this.cimenterie,
    required this.produit,
    required this.prix,
    required this.reclamation,
  });

  // Convert Visit instance to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      '_id': mongoId,  // Include _id if it exists, otherwise MongoDB generates it
      'date': date.toIso8601String(),
      'client': client,
      'responsable': responsable,
      'cimenterie': cimenterie,
      'produit': produit,
      'prix': prix,
      'reclamation': reclamation,
    };
  }

  // Create a Visit instance from a Map
  factory Visit.fromMap(Map<String, dynamic> map) {
    return Visit(
      mongoId: map['_id'] is ObjectId ? map['_id'] : null,  // Assign _id as ObjectId
      date: DateTime.parse(map['date']),
      client: map['client'],
      responsable: map['responsable'],
      cimenterie: map['cimenterie'],
      produit: map['produit'],
      prix: map['prix'],
      reclamation: map['reclamation'],
    );
  }
}
