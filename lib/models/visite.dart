import 'dart:io';

import 'package:mailer/mailer.dart';

class Cimenterie_visite {
  late String Nom;
  late String produit;
  late double prix;

  Cimenterie_visite({
    required this.Nom,
    required this.produit,
    required this.prix,
  });

  factory Cimenterie_visite.fromJson(Map<String, dynamic> json) {
    return Cimenterie_visite(
      Nom: json['Nom'],
      produit: json['produit'],
      prix: json['prix'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Nom': Nom,
        'produit': produit,
        'prix': prix,
      };
}

class Visite {
  late DateTime date;
  late String Nom_Client;
  late String Nom_Responsable;
  late List<Cimenterie_visite> cimenteries;
  late String observations;
  late String Reclamation;
  late List<File>? Documents;

  Visite({
    required this.date,
    required this.Nom_Client,
    required this.Nom_Responsable,
    required this.cimenteries,
    required this.observations,
    required this.Reclamation,
    this.Documents,
  });

  factory Visite.fromJson(Map<String, dynamic> json) {
    return Visite(
      date: DateTime.parse(json['date']),
      Nom_Client: json['Nom_Client'],
      Nom_Responsable: json['Nom_Responsable'],
      cimenteries: (json['cimenteries'] as List)
          .map((i) => Cimenterie_visite.fromJson(i))
          .toList(),
      observations: json['observations'],
      Reclamation: json['Reclamation'],
      Documents: (json['Documents'] as List?)?.map((i) => File(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'Nom_Client': Nom_Client,
        'Nom_Responsable': Nom_Responsable,
        'cimenteries': cimenteries.map((i) => i.toJson()).toList(),
        'observations': observations,
        'Reclamation': Reclamation,
        'Documents': Documents?.map((i) => i.path).toList(),
      };

  bool isValid() {
    return Nom_Client.isNotEmpty &&
        Nom_Responsable.isNotEmpty &&
        cimenteries.isNotEmpty &&
        observations.isNotEmpty &&
        Reclamation.isNotEmpty;
  }
}