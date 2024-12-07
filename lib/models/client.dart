import 'dart:ffi';

import 'package:mongo_dart/mongo_dart.dart';

class Client {
  ObjectId mongoId; // MongoDB _id field
  String type; // G, D ou NC
  String responsable;
  Int telephone;
  String gouvernorat;
  String delegation;
  String adresse;
  String email;
  String cimenterie;
  List<ObjectId> produits;
  Double prix;

  Client({
    required this.mongoId,
    required this.type,
    required this.responsable,
    required this.telephone,
    required this.gouvernorat,
    required this.delegation,
    required this.adresse,
    required this.email,
    required this.cimenterie,
    required this.produits,
    required this.prix,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    // Check and print out the raw JSON for debugging
    print('Parsing client JSON: $json');

    // Parse the JSON data, ensuring non-null fields are properly handled
    return Client(
        mongoId: json["_id"] as ObjectId,
        type: json["id"] ?? '', // Use a default empty string if null
        responsable:
            json["responsable"] ?? '', // Use a default empty string if null
        telephone: json["telephone"] ?? '',
        gouvernorat: json["gouvernorat"] ?? '',
        delegation: json["delegation"] ?? '',
        adresse: json["adresse"] ?? '',
        email: json["email"] ?? '',
        cimenterie: json["cimenterie"] ?? '',
        produits: json["produits"] ?? '',
        prix: json["prix"] ?? '' // Use a default empty string if null
        );
  }

  Map<String, dynamic> toJson() => {
        "_id": mongoId, // MongoDB _id field
        "type": type,
        "responsable": responsable,
        "telephone": telephone,
        "gouvernorat": gouvernorat,
        "delegation": delegation,
        "adresse": adresse,
        "email": email,
        "cimenterie": cimenterie,
        "produits": produits,
        "prix": prix,
      };

  // Method to check if the required fields are valid
  bool isValid() {
    return type.isNotEmpty &&
        responsable.isNotEmpty &&
        telephone.toString().isEmpty &&
        gouvernorat.isNotEmpty &&
        delegation.isNotEmpty &&
        adresse.isNotEmpty &&
        cimenterie.isNotEmpty &&
        email.isNotEmpty &&
        produits.isNotEmpty &&
        prix.toString().isNotEmpty;
  }
  
}
