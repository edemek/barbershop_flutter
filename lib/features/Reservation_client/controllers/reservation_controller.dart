import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReservationController extends GetxController {
  // Liste des réservations (par exemple, pour stocker les réservations confirmées)
  var reservations = <Map<String, String>>[].obs;

  // Liste des salons disponibles
  final List<String> salons = ['Salon A', 'Salon B', 'Salon C'];

  // Liste des services disponibles
  final List<String> services = ['Massage Relaxant', 'Manicure', 'Coiffure'];

  // Valeur sélectionnée pour le service (initialement null pour indiquer aucune sélection)
  var selectedService = Rxn<String>(); // Cela permet à la valeur d'être null

  // Valeur sélectionnée pour le salon (initialement null pour indiquer aucune sélection)
  var selectedSalon = Rxn<String>(); // Cela permet à la valeur d'être null

  // Date et heure de réservation
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  // Méthode de confirmation de la réservation
  void confirmReservation() {
    // Cette méthode pourrait envoyer la réservation ou effectuer une autre logique
    print("Réservation confirmée pour $selectedService, $selectedSalon, $selectedDate, $selectedTime");
  }
}
