import 'package:flutter/material.dart';
import 'parent/model.dart';

class Salon extends Model {
  String? id;
  String nom = "eee";
  String? description;
  List<String>? images;
  String? phoneNumber;
  String? landlineNumber;
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;

  // Constructeur de la classe Salon
  Salon({
    this.id,
    String? nom,
    String? description,
    List<String>? images,
    this.phoneNumber,
    this.landlineNumber,
    this.openingTime,
    this.closingTime,
  }) {
    this.id = id;
    this.images = images ?? [];
  }

  // Factory constructor pour convertir un JSON en objet Salon
  factory Salon.fromJson(Map<String, dynamic> json) {
    return Salon(
      // id: json['id'] ?? 0, // Si la clé 'id' est absente, on met 0 par défaut
      nom: json['nom'] ?? '', // Nom du salon, chaîne vide par défaut si null
      description: json['description'] ?? '', // Description du salon
      images: (json['images'] as List<String>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      phoneNumber: json['phone_number'] ?? '', // Numéro de téléphone mobile
      landlineNumber: json['landline_number'] ?? '', // Numéro de téléphone fixe
      openingTime: _parseTimeOfDay(
          json['opening_time']), // Convertit l'heure d'ouverture en TimeOfDay
      closingTime: _parseTimeOfDay(
          json['closing_time']), // Convertit l'heure de fermeture en TimeOfDay
    );
  }

  Salon.fromJson_(Map<String, dynamic>? json) {
    super.fromJson(json);
    nom = transStringFromJson(json, 'nom');
    description = transStringFromJson(json, 'description');
    // images = mediaListFromJson(json, 'images');
    phoneNumber = stringFromJson(json, 'phone_number');
    // mobileNumber = stringFromJson(json, 'mobile_number');
    // salonLevel =
    //     objectFromJson(json, 'salon_level', (v) => SalonLevel.fromJson(v));
    // availabilityHours = listFromJson(
    //     json, 'availability_hours', (v) => AvailabilityHour.fromJson(v));
    // availabilityRange = doubleFromJson(json, 'availability_range');
    // distance = doubleFromJson(json, 'distance');
    // closed = boolFromJson(json, 'closed');
    // featured = boolFromJson(json, 'featured');
    // address = objectFromJson(json, 'address', (v) => Address.fromJson(v));
    // taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
    // employees = listFromJson(json, 'users', (v) => User.fromJson(v));
    // rate = doubleFromJson(json, 'rate');
    // reviews = listFromJson(json, 'salon_reviews', (v) => Review.fromJson(v));
    // totalReviews =
    //     reviews!.isEmpty ? intFromJson(json, 'total_reviews') : reviews!.length;
    // verified = boolFromJson(json, 'verified');
    images = ((json != null) ? json['images'] : [])
            ?.map((e) => e.toString())
            .toList() ??
        [];
    openingTime = _parseTimeOfDay((json != null)
        ? json['opening_time']
        : ""); // Convertit l'heure d'ouverture en TimeOfDay
    closingTime = _parseTimeOfDay((json != null)
        ? json['closing_time']
        : ""); // Convertit l'heure de fermeture en TimeOfDay
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
      'opening_time': _formatTimeOfDay(
          openingTime), // Convertit TimeOfDay en format "HH:mm"
      'closing_time': _formatTimeOfDay(
          closingTime), // Convertit TimeOfDay en format "HH:mm"
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
  static String _formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return "ooooo";
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
