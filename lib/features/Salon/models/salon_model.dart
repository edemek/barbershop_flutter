import 'package:flutter/material.dart';

class Salon {
  int id;
  String nom;
  String description;
  List<String> images;
  String phoneNumber;
  String landlineNumber;
  TimeOfDay openingTime;
  TimeOfDay closingTime;
  bool closed;

  // Constructeur de la classe Salon
  Salon({
    required this.id,
    required this.nom,
    required this.description,
    required this.images,
    required this.phoneNumber,
    required this.landlineNumber,
    required this.openingTime,
    required this.closingTime,
    required this.closed,

  });

  // Factory constructor pour convertir un JSON en objet Salon
  factory Salon.fromJson(Map<String, dynamic> json) {
    return Salon(
      id: json['id'] ?? 0, // Si la clé 'id' est absente, on met 0 par défaut
      nom: json['name'] ?? '', // Nom du salon, chaîne vide par défaut si null
      description: json['description'] ?? '', // Description du salon
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      phoneNumber: json['phone_number'] ?? '', // Numéro de téléphone mobile
      landlineNumber: json['landline_number'] ?? '', // Numéro de téléphone fixe
      openingTime: _parseTimeOfDay(json['opening_time']), // Convertit l'heure d'ouverture en TimeOfDay
      closingTime: _parseTimeOfDay(json['closing_time']),
      closed: json['closed'],// Convertit l'heure de fermeture en TimeOfDay
    );
  }

  // Convertit un objet Salon en Map<String, dynamic> pour le convertir en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'images': images,
      'phone_number': phoneNumber,
      'landline_number': landlineNumber,
      'opening_time': _formatTimeOfDay(openingTime), // Convertit TimeOfDay en format "HH:mm"
      'closing_time': _formatTimeOfDay(closingTime), // Convertit TimeOfDay en format "HH:mm"
    };
  }

  // Méthode privée pour convertir une chaîne "HH:mm" en TimeOfDay
  static TimeOfDay _parseTimeOfDay(String? time) {
    if (time == null || !RegExp(r'^\d{1,2}:\d{2}$').hasMatch(time)) {
      return const TimeOfDay(hour: 8, minute: 0); // Heure par défaut : 08:00
    }
    final parts = time.split(':'); // Sépare la chaîne en heure et minute
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  // Méthode privée pour convertir un TimeOfDay en chaîne "HH:mm"
  static String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
