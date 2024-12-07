import 'package:mongo_dart/mongo_dart.dart';

class Client {
  ObjectId mongoId; // MongoDB _id field
  String type; // G, D ou NC
  String responsable;
  int telephone;
  String gouvernorat;
  String delegation;
  String adresse;
  String email;
  String cimenterie;
  String produits;
  double prix;

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
    print('Parsing client JSON: $json');
    return Client(
      mongoId: json["_id"] as ObjectId,
      type: json["type"] ?? '',
      responsable: json["responsable"] ?? '',
      telephone: json["telephone"] ?? 0,
      gouvernorat: json["gouvernorat"] ?? '',
      delegation: json["delegation"] ?? '',
      adresse: json["adresse"] ?? '',
      email: json["email"] ?? '',
      cimenterie: json["cimenterie"] ?? '',
      produits: json["produits"] ?? '',
      prix: json["prix"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": mongoId,
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

  bool isValid() {
    return type.isNotEmpty &&
        responsable.isNotEmpty &&
        telephone != 0 &&
        gouvernorat.isNotEmpty &&
        delegation.isNotEmpty &&
        adresse.isNotEmpty &&
        email.isNotEmpty &&
        cimenterie.isNotEmpty &&
        produits.isNotEmpty &&
        prix != 0.0;
  }
}
