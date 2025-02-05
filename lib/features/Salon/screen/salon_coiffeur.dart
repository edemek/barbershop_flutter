import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/salon_model.dart';

void main() {
  runApp(SalonViewForm());
}

/// Thème personnalisé utilisant du noir clair, du doré et du blanc.
class SalonViewForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Salons',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black, // Noir clair
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Color(0xFFFFD700)), // Doré
          titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD700),
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Color(0xFFFFD700),
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: SalonListPage(),
    );
  }
}

/// Modèle représentant un salon.

/// Page affichant la liste des salons créés.
class SalonListPage extends StatefulWidget {
  @override
  _SalonListPageState createState() => _SalonListPageState();
}

class _SalonListPageState extends State<SalonListPage> {
  List<Salon> salons = [];
  int _nextId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Liste des Salons",
          style: TextStyle(color: Color(0xFFFFD700)),
        ),
        centerTitle: true,
      ),
      body: salons.isEmpty
          ? Center(
              child: Text(
                "Aucun salon n'a été créé.Commencer par en créer en cliquant sur le button + en bas de l'écran",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: salons.length,
              itemBuilder: (context, index) {
                final salon = salons[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  elevation: 4,
                  child: ListTile(
                    leading: salon.images!.isNotEmpty
                        ? Image.file(
                            File(salon.images![0]),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.store,
                            color: Color(0xFFFFD700),
                            size: 50,
                          ),
                    title: Text(
                      salon.nom,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      salon.description ?? "",
                      style: TextStyle(color: Colors.black87),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bouton de modification
                        IconButton(
                          icon: Icon(Icons.edit, color: Color(0xFFFFD700)),
                          onPressed: () async {
                            final updatedSalon = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SalonFormPage(salon: salon),
                              ),
                            );
                            if (updatedSalon != null) {
                              setState(() {
                                salons[index] = updatedSalon;
                              });
                            }
                          },
                        ),
                        // Bouton de suppression
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Confirmer la suppression"),
                                content:
                                    Text("Voulez-vous supprimer ce salon ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        salons.removeAt(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Supprimer",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newSalon = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalonFormPage(),
            ),
          );
          if (newSalon != null) {
            setState(() {
              newSalon.id = _nextId;
              _nextId++;
              salons.add(newSalon);
            });
          }
        },
        child: Icon(Icons.add),
        tooltip: "Ajouter un Salon",
      ),
    );
  }
}

/// Page permettant de créer ou de modifier un salon.
class SalonFormPage extends StatefulWidget {
  final Salon? salon; // Si null, création d'un nouveau salon

  SalonFormPage({this.salon});

  @override
  _SalonFormPageState createState() => _SalonFormPageState();
}

class _SalonFormPageState extends State<SalonFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _landlineNumberController;
  // La liste des chemins d'accès aux images sélectionnées (maximum 4 images)
  List<String> _imagePaths = [];
  // Champs pour les horaires, avec des valeurs par défaut
  TimeOfDay _openingTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _closingTime = TimeOfDay(hour: 18, minute: 0);

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.salon?.nom ?? "");
    _descriptionController =
        TextEditingController(text: widget.salon?.description ?? "");
    _phoneNumberController =
        TextEditingController(text: widget.salon?.phoneNumber ?? "");
    _landlineNumberController =
        TextEditingController(text: widget.salon?.landlineNumber ?? "");
    _imagePaths = widget.salon?.images ?? [];
    if (widget.salon != null) {
      // _openingTime = widget.salon?.openingTime;
      _openingTime = TimeOfDay(hour: 0, minute: 0);
      // _closingTime = widget.salon?.closingTime;
      _closingTime = TimeOfDay(hour: 0, minute: 0);
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _descriptionController.dispose();
    _phoneNumberController.dispose();
    _landlineNumberController.dispose();
    super.dispose();
  }

  /// Permet de sélectionner une image depuis la galerie ou via l'appareil photo.
  Future<void> _pickImage(ImageSource source) async {
    if (_imagePaths.length >= 4) return;
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePaths.add(pickedFile.path);
      });
    }
  }

  /// Supprime l'image sélectionnée.
  void _removeImage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  /// Permet de sélectionner une heure à l'aide d'un TimePicker.
  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime,
      ValueChanged<TimeOfDay> onSelected) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (newTime != null) {
      onSelected(newTime);
    }
  }

  /// Enregistre le salon et retourne l'objet via Navigator.pop.
  void _enregistrer() {
    if (_formKey.currentState!.validate()) {
      final salon = Salon(
        id: widget.salon?.id ?? "0",
        nom: _nomController.text,
        description: _descriptionController.text,
        images: _imagePaths,
        phoneNumber: _phoneNumberController.text,
        landlineNumber: _landlineNumberController.text,
        openingTime: _openingTime,
        closingTime: _closingTime,
      );
      Navigator.pop(context, salon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.salon == null ? "Créer un Salon" : "Modifier le Salon",
          style: TextStyle(color: Color(0xFFFFD700)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: "Nom du Salon",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return "Veuillez entrer le nom du salon";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return "Veuillez entrer une description";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: "Numéro de téléphone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return "Veuillez entrer un numéro de téléphone";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _landlineNumberController,
                decoration: InputDecoration(
                  labelText: "Numéro fixe",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return "Veuillez entrer un numéro fixe";
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Sélection de l'horaire d'ouverture
              ListTile(
                title: Text("Heure d'ouverture"),
                trailing: Text("${_openingTime.format(context)}"),
                onTap: () => _selectTime(context, _openingTime, (newTime) {
                  setState(() {
                    _openingTime = newTime;
                  });
                }),
              ),
              // Sélection de l'horaire de fermeture
              ListTile(
                title: Text("Heure de fermeture"),
                trailing: Text("${_closingTime.format(context)}"),
                onTap: () => _selectTime(context, _closingTime, (newTime) {
                  setState(() {
                    _closingTime = newTime;
                  });
                }),
              ),
              SizedBox(height: 16),
              Text(
                "Images du salon (maximum 4)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Affichage des images sélectionnées
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_imagePaths.length, (index) {
                  return Stack(
                    children: [
                      Image.file(
                        File(_imagePaths[index]),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: -10,
                        top: -10,
                        child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () => _removeImage(index),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 8),
              // Boutons pour ajouter une image depuis la galerie ou la caméra
              if (_imagePaths.length < 4)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: Icon(Icons.photo_library),
                      label: Text("Galerie"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt),
                      label: Text("Appareil photo"),
                    ),
                  ],
                ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _enregistrer,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.salon == null ? "Créer" : "Enregistrer",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
