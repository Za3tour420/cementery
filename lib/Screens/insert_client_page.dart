import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/client.dart';
import '../dbHelper/client_crud.dart';

class InsertClientPage extends StatelessWidget {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController responsableController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController gouvernoratController = TextEditingController();
  final TextEditingController delegationController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cimenterieController = TextEditingController();
  final TextEditingController produitsController = TextEditingController(); // Comma-separated ObjectIds
  final TextEditingController prixController = TextEditingController();

  InsertClientPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert Client')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: responsableController,
              decoration: InputDecoration(labelText: 'Responsable'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: telephoneController,
              decoration: InputDecoration(labelText: 'Telephone'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: gouvernoratController,
              decoration: InputDecoration(labelText: 'Gouvernorat'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: delegationController,
              decoration: InputDecoration(labelText: 'Delegation'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: adresseController,
              decoration: InputDecoration(labelText: 'Adresse'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: cimenterieController,
              decoration: InputDecoration(labelText: 'Cimenterie'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: produitsController,
              decoration: InputDecoration(labelText: 'Produits (comma-separated ObjectIds)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: prixController,
              decoration: InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final client = Client(
                  mongoId: ObjectId(),
                  type: typeController.text.trim(),
                  responsable: responsableController.text.trim(),
                  telephone: int.tryParse(telephoneController.text.trim()) ?? 0,
                  gouvernorat: gouvernoratController.text.trim(),
                  delegation: delegationController.text.trim(),
                  adresse: adresseController.text.trim(),
                  email: emailController.text.trim(),
                  cimenterie: cimenterieController.text.trim(),
                  produits: produitsController.text.trim(),
                  prix: double.tryParse(prixController.text.trim()) ?? 0.0,
                );
                await createClient(client);
                Fluttertoast.showToast(
                  msg: "Successfully inserted product ${client.type} ${client.responsable}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Navigator.pop(context);
              },
              child: Text('Insert'),
            ),
          ],
        ),
      ),
    );
  }
}
