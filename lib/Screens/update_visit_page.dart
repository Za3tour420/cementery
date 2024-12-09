/*import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/visit.dart';
import '../dbHelper/visit_crud.dart';

class UpdateVisitPage extends StatefulWidget {
  final Visit visit;

  const UpdateVisitPage({super.key, required this.visit});

  @override
  _UpdateVisitPageState createState() => _UpdateVisitPageState();
}

class _UpdateVisitPageState extends State<UpdateVisitPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _clientController;
  late TextEditingController _responsableController;
  late TextEditingController _cimenterieController;
  late TextEditingController _produitController;
  late TextEditingController _prixController;
  late TextEditingController _reclamationController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _clientController = TextEditingController(text: widget.visit.client);
    _responsableController = TextEditingController(text: widget.visit.responsable);
    _cimenterieController = TextEditingController(text: widget.visit.cimenterie);
    _produitController = TextEditingController(text: widget.visit.produit);
    _prixController = TextEditingController(text: widget.visit.prix.toString());
    _reclamationController = TextEditingController(text: widget.visit.reclamation);
    _dateController = TextEditingController(text: widget.visit.date.toIso8601String());
  }

  @override
  void dispose() {
    _clientController.dispose();
    _responsableController.dispose();
    _cimenterieController.dispose();
    _produitController.dispose();
    _prixController.dispose();
    _reclamationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _updateVisit() async {
    if (_formKey.currentState!.validate()) {
      final updatedVisit = Visit(
        date: DateTime.parse(_dateController.text.trim()), // Parse the date input
        client: _clientController.text.trim(),
        responsable: _responsableController.text.trim(),
        cimenterie: _cimenterieController.text.trim(),
        produit: _produitController.text.trim(),
        prix: double.tryParse(_prixController.text.trim()) ?? 0.0,
        reclamation: _reclamationController.text.trim(),
      );
      
      await updateVisit(updatedVisit);
      
      Fluttertoast.showToast(
        msg: "Successfully updated visit for ${updatedVisit.client}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Visit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _clientController,
                decoration: InputDecoration(labelText: 'Client'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a client name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _responsableController,
                decoration: InputDecoration(labelText: 'Responsable'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a responsable name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cimenterieController,
                decoration: InputDecoration(labelText: 'Cimenterie'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cimenterie name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _produitController,
                decoration: InputDecoration(labelText: 'Produit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a produit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _prixController,
                decoration: InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _reclamationController,
                decoration: InputDecoration(labelText: 'Reclamation'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reclamation';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid date';
                  }
                  try {
                    DateTime.parse(value);
                  } catch (e) {
                    return 'Please enter a valid date in format YYYY-MM-DD';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateVisit,
                child: Text('Update Visit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/