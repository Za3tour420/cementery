import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dbHelper/client_crud.dart';
import '../models/client.dart';

class UpdateClientPage extends StatefulWidget {
  final Client client;

  const UpdateClientPage({super.key, required this.client});

  @override
  _UpdateClientPageState createState() => _UpdateClientPageState();
}

class _UpdateClientPageState extends State<UpdateClientPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _typeController;
  late TextEditingController _responsableController;
  late TextEditingController _telephoneController;
  late TextEditingController _gouvernoratController;
  late TextEditingController _delegationController;
  late TextEditingController _adresseController;
  late TextEditingController _emailController;
  late TextEditingController _cimenterieController;
  late TextEditingController _produitsController;
  late TextEditingController _prixController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.client.type);
    _responsableController = TextEditingController(text: widget.client.responsable);
    _telephoneController = TextEditingController(text: widget.client.telephone.toString());
    _gouvernoratController = TextEditingController(text: widget.client.gouvernorat);
    _delegationController = TextEditingController(text: widget.client.delegation);
    _adresseController = TextEditingController(text: widget.client.adresse);
    _emailController = TextEditingController(text: widget.client.email);
    _cimenterieController = TextEditingController(text: widget.client.cimenterie);
    _produitsController = TextEditingController(text: widget.client.produits.toString());
    _prixController = TextEditingController(text: widget.client.prix.toString());
  }

  @override
  void dispose() {
    _typeController.dispose();
    _responsableController.dispose();
    _telephoneController.dispose();
    _gouvernoratController.dispose();
    _delegationController.dispose();
    _adresseController.dispose();
    _emailController.dispose();
    _cimenterieController.dispose();
    _produitsController.dispose();
    _prixController.dispose();
    super.dispose();
  }

  Future<void> _updateClient() async {
    if (_formKey.currentState!.validate()) {
      final updatedClient = Client(
        mongoId: widget.client.mongoId,
        type: _typeController.text,
        responsable: _responsableController.text,
        telephone: int.tryParse(_telephoneController.text) ?? 0,
        gouvernorat: _gouvernoratController.text,
        delegation: _delegationController.text,
        adresse: _adresseController.text,
        email: _emailController.text,
        cimenterie: _cimenterieController.text,
        produits: _produitsController.text,
        prix: double.tryParse(_prixController.text) ?? 0,
      );
      await updateClient(updatedClient);
      Fluttertoast.showToast(
                  msg: "Successfully updated Client ${updatedClient.type} ${updatedClient.responsable}",
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
      appBar: AppBar(title: Text('Update Client')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Client Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Client Type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _responsableController,
                decoration: InputDecoration(labelText: 'Responsable'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a responsable';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateClient,
                child: Text('Update Client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
