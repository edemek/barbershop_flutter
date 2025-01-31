import 'package:barbershpo_flutter/features/Reservation_client/views/reservation_liste.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  // Définition d'une palette de couleurs personnalisée pour un design cohérent
  static const Color goldColor = Color(0xFFD4AF37);     // Couleur dorée pour les accents
  static const Color lightBlack = Color(0xFF333333);    // Noir clair pour le texte principal
  static const Color offWhite = Color(0xFFF5F5F5);     // Blanc cassé pour le fond

  // Variables pour stocker les sélections de l'utilisateur
  String? selectedService;    // Service sélectionné
  DateTime selectedDate = DateTime.now();  // Date de réservation (initialisée à aujourd'hui)
  TimeOfDay selectedTime = TimeOfDay.now();  // Heure de réservation (initialisée à l'heure actuelle)
  String? selectedSalon;  // Salon sélectionné

  // Listes des services et salons disponibles
  final List<String> services = ['Massage Relaxant', 'Manicure', 'Coiffure'];
  final List<String> salons = ['Salon A', 'Salon B', 'Salon C'];

  // Fonction pour sélectionner une date de réservation
  Future<void> _selectDate(BuildContext context) async {
    // Configuration de la plage de dates acceptables
    final DateTime firstDate = DateTime.now(); // Aujourd'hui comme date minimum
    final DateTime lastDate = DateTime(DateTime.now().year + 2); // 2 ans dans le futur

    // Affichage du sélecteur de date avec personnalisation du thème
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Date initialement sélectionnée
      firstDate: firstDate,      // Limite basse : aujourd'hui
      lastDate: lastDate,        // Limite haute : 2 ans dans le futur
      builder: (context, child) {
        return Theme(
          // Personnalisation du thème du sélecteur de date
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: goldColor,     // Couleur primaire personnalisée
              onPrimary: Colors.white, // Couleur du texte sur la couleur primaire
              surface: Colors.white,   // Couleur de surface
              onSurface: lightBlack,   // Couleur du texte sur la surface
            ),
            dialogBackgroundColor: Colors.white, // Fond de la boîte de dialogue
          ),
          child: child!,
        );
      },
    );

    // Mise à jour de la date si une nouvelle date est sélectionnée
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Fonction pour sélectionner une heure de réservation
  Future<void> _selectTime(BuildContext context) async {
    // Affichage du sélecteur d'heure avec personnalisation du thème
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          // Personnalisation du thème du sélecteur d'heure
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: goldColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: lightBlack,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    // Mise à jour de l'heure si une nouvelle heure est sélectionnée
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Fonction pour confirmer la réservation
  void _confirmReservation() {
    if (selectedService == null || selectedSalon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez sélectionner un service et un salon"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(selectedDate);
    final formattedTime = selectedTime.format(context);
    List<Map<String, String>> reservations = [];
    // Ajouter la réservation à la liste
    setState(() {
      reservations.add({
        'service': selectedService!,
        'salon': selectedSalon!,
        'date': formattedDate,
        'heure': formattedTime,
      });
    });
    ReservationListePage(reservations);
    // Notification de confirmation de réservation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Réservation confirmée ! Un e-mail vous a été envoyé")),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond de l'écran en blanc cassé
      backgroundColor: offWhite,

      // Barre d'application personnalisée
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Pas d'ombre
        title: Text(
          'Réservation',
          style: TextStyle(color: lightBlack),
        ),
        // Personnalisation de l'icône de retour
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: lightBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      // Corps de la page avec défilement
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section de sélection du salon
              _buildSectionTitle("Choisissez un salon"),
              _buildDropdown(
                value: selectedSalon,
                hint: 'Sélectionnez un salon',
                items: salons,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSalon = newValue;
                  });
                },
              ),
              SizedBox(height: 20),

              // Section de sélection du service
              _buildSectionTitle("Choisissez un service"),
              _buildDropdown(
                value: selectedService,
                hint: 'Sélectionnez un service',
                items: services,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedService = newValue;
                  });
                },
              ),
              SizedBox(height: 20),

              // Section de sélection de la date
              _buildSectionTitle("Choisissez une date"),
              _buildDateTimeSelector(
                text: DateFormat('dd MMMM yyyy').format(selectedDate),
                icon: Icons.calendar_today,
                onPressed: () => _selectDate(context),
              ),
              SizedBox(height: 20),

              // Section de sélection de l'heure
              _buildSectionTitle("Choisissez une heure"),
              _buildDateTimeSelector(
                text: selectedTime.format(context),
                icon: Icons.access_time,
                onPressed: () => _selectTime(context),
              ),
              SizedBox(height: 30),

              // Bouton de confirmation de réservation
              ElevatedButton(
                onPressed: _confirmReservation,
                child: Text('Confirmer la réservation'),
                style: ElevatedButton.styleFrom(
                  //primary: goldColor,
                  minimumSize: Size(double.infinity, 50), // Largeur maximale
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget personnalisé pour les titres de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: lightBlack,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget personnalisé pour les menus déroulants
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      hint: Text(hint),
      isExpanded: true,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Widget personnalisé pour la sélection de date/heure
  Widget _buildDateTimeSelector({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(color: lightBlack),
        ),
        IconButton(
          icon: Icon(icon, color: goldColor),
          onPressed: onPressed,
        ),
      ],
    );
  }
}