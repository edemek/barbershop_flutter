import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'experienceListPage.dart';
import 'experience_card.dart';

class ShareExperience extends StatefulWidget {

  @override
  _ShareExperienceState createState() => _ShareExperienceState();
}

class _ShareExperienceState extends State<ShareExperience> {
  static List<Map<String,dynamic>> experienceList = [

  ];
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  File? beforeImage;
  File? afterImage;
  final picker = ImagePicker();

  // Définition des couleurs principales
  static const Color primaryGold = Color(0xFFDAA520);  // Or plus doux
  static const Color backgroundBlack = Color(0xFF1A1A1A);  // Noir plus doux
  static const Color softWhite = Color(0xFFF5F5F5);  // Blanc légèrement atténué
  static const Color darkGrey = Color(0xFF2A2A2A);  // Gris foncé pour les éléments secondaires

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
    } else {
      await Permission.photos.request();
    }
    await Permission.camera.request();
  }

  Future<void> _pickImage(bool isBeforeImage, ImageSource source) async {
    try {
      PermissionStatus permission = source == ImageSource.camera
          ? await Permission.camera.request()
          : await (Platform.isAndroid ? Permission.storage.request() : Permission.photos.request());

      if (!permission.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Permission refusée ! Activez-la dans les paramètres."),
            backgroundColor: darkGrey,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final pickedFile = await picker.pickImage(source: source, maxWidth: 600);

      if (pickedFile != null) {
        setState(() {
          if (isBeforeImage) {
            beforeImage = File(pickedFile.path);
          } else {
            afterImage = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la sélection de l'image: $e"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _initField() {
    _descriptionController.clear();
    _tagsController.clear();
    beforeImage = null;
    afterImage = null;
  }

  void _submitExperience() {
    if (beforeImage == null || afterImage == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez remplir tous les champs et ajouter des photos"),
          backgroundColor: darkGrey,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      experienceList.add({
        "beforeImage": beforeImage,
        "afterImage": afterImage,
        "description": _descriptionController.text,
        "taggedSalon": _tagsController.text,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Votre expérience est soumis avec succès en attente d'approbation!"),
        backgroundColor: primaryGold,
        behavior: SnackBarBehavior.floating,
      ),
    );
    _initField();
    ExperienceListPage.experiences.add(experienceList as Map<String, dynamic>);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      appBar: AppBar(
        title: Text(
          "Partager mon expérience",
          style: TextStyle(
            color: softWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: darkGrey,
        elevation: 0,
        iconTheme: IconThemeData(color: softWhite),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [darkGrey, backgroundBlack],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImagePicker(true),
                    _buildImagePicker(false),
                  ],
                ),
                SizedBox(height: 24),
                _buildTextField("Description", _descriptionController),
                SizedBox(height: 20),
                _buildTextField("Taguer le salon/coiffeur", _tagsController),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitExperience,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGold,
                      foregroundColor: backgroundBlack,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      "Publier mon expérience",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(bool isBeforeImage) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryGold.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Text(
            isBeforeImage ? "Avant" : "Après",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: softWhite,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: backgroundBlack,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryGold, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: primaryGold.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: (isBeforeImage ? beforeImage : afterImage) == null
                ? Icon(Icons.camera_alt, size: 45, color: primaryGold)
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                isBeforeImage ? beforeImage! : afterImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconButton(Icons.camera, () => _pickImage(isBeforeImage, ImageSource.camera)),
              SizedBox(width: 16),
              _buildIconButton(Icons.photo_library, () => _pickImage(isBeforeImage, ImageSource.gallery)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryGold.withOpacity(0.3)),
      ),
      child: IconButton(
        icon: Icon(icon, color: primaryGold),
        onPressed: onPressed,
        padding: EdgeInsets.all(8),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryGold.withOpacity(0.3)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        style: TextStyle(color: softWhite, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: softWhite.withOpacity(0.7)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        maxLines: label == "Description" ? 4 : 1,
      ),
    );
  }
}