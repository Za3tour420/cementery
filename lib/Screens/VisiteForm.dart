import 'dart:io';

import 'package:cementery/dbHelper/visite_crud.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:cementery/models/visite.dart';
import '../dbHelper/visite_crud.dart';

import '../models/product.dart';

class VisiteForm extends StatefulWidget {
  const VisiteForm({super.key});
  @override
  _VisiteFormState createState() => _VisiteFormState();
}

class _VisiteFormState extends State<VisiteForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String _selectedClient = 'Client 1';
  String _responsable = '';
  List<Cimenterie_visite> _cimenteries = [];
  String _observations = '';
  String _reclamation = '';
  List<File> _documents = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) => setState(() {
            _observations = val.recognizedWords;
          }));
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _documents = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  void _addCimenterie() {
    setState(() {
      _cimenteries.add(Cimenterie_visite(Nom: '', produit: '', prix: 0.0));
    });
  }

  void _submitForm()  async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Visite visite = Visite(
        date: _selectedDate,
        Nom_Responsable: _responsable,
        cimenteries: _cimenteries,
        observations: _observations,
        Reclamation: _reclamation,
        Documents: _documents, 
        Nom_Client: 'Client 1',
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Visite')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                title: Text("Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}"),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              DropdownButtonFormField<String>(
                value: _selectedClient,
                items: ['Client 1', 'Client 2'].map((String client) {
                  return DropdownMenuItem<String>(
                    value: client,
                    child: Text(client),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedClient = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Client'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Responsable'),
                onSaved: (value) {
                  _responsable = value!;
                },
              ),
              ..._cimenteries.map((cimenterie) {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Cimenterie'),
                        onSaved: (value) {
                          cimenterie.Nom = value!;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Produit'),
                        onSaved: (value) {
                          cimenterie.produit = value!;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Prix'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          cimenterie.prix = double.parse(value!);
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
              TextButton(
                onPressed: _addCimenterie,
                child: Text('Add Cimenterie'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Observations'),
                      onSaved: (value) {
                        _observations = value!;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    onPressed: _isListening ? _stopListening : _startListening,
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reclamation'),
                onSaved: (value) {
                  _reclamation = value!;
                },
              ),
              TextButton(
                onPressed: _pickFiles,
                child: Text('Attach Files'),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}