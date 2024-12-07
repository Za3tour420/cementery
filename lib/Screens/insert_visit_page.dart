import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/visit.dart';
import '../dbHelper/visit_crud.dart';

class InsertVisitPage extends StatelessWidget {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController clientController = TextEditingController();
  final TextEditingController responsableController = TextEditingController();
  final TextEditingController cimenterieController = TextEditingController();
  final TextEditingController produitController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController reclamationController = TextEditingController();

  InsertVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert Visit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date (yyyy-mm-dd)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            TextField(
              controller: clientController,
              decoration: InputDecoration(labelText: 'Client'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: responsableController,
              decoration: InputDecoration(labelText: 'Responsable'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: cimenterieController,
              decoration: InputDecoration(labelText: 'Cimenterie'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: produitController,
              decoration: InputDecoration(labelText: 'Produit'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: prixController,
              decoration: InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextField(
              controller: reclamationController,
              decoration: InputDecoration(labelText: 'Reclamation'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final visit = Visit(
                    mongoId: ObjectId(),  // Optional _id is generated
                    date: DateTime.parse(dateController.text.trim()),
                    client: clientController.text.trim(),
                    responsable: responsableController.text.trim(),
                    cimenterie: cimenterieController.text.trim(),
                    produit: produitController.text.trim(),
                    prix: double.parse(prixController.text.trim()),
                    reclamation: reclamationController.text.trim(),
                  );
                  await createVisit(visit); // Insert the visit into the database
                  Navigator.pop(context); // Go back to the previous page
                  Fluttertoast.showToast(
                    msg: "Successfully inserted visit for ${visit.client}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: "Error: $e",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: Text('Insert Visit'),
            ),
          ],
        ),
      ),
    );
  }
}
