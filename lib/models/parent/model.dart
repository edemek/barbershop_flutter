/*
 * File name: model.dart
 * Last modified: 2022.10.16 at 12:23:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:convert'; // Importation de la bibliothèque pour la manipulation des données JSON

import 'package:flutter/cupertino.dart'; // Importation des outils Flutter pour iOS
import 'package:get/get.dart'; // Importation du package GetX pour la gestion d'état et des dépendances
import 'package:intl/intl.dart' show DateFormat; // Importation pour la gestion des formats de date

import '../../../common/ui.dart'; // Importation de fichiers communs spécifiques au projet
//import '../media_model.dart'; // Importation commentée, probablement pour les médias

abstract class Model {
  String? _id; // Déclaration d'un champ privé pour stocker l'identifiant

  // Getter pour accéder à l'identifiant
  String get id => _id ?? '';

  // Setter pour modifier l'identifiant
  set id(String? value) {
    _id = value;
  }

  // Vérifie si l'objet a des données (si l'identifiant n'est pas nul)
  bool get hasData => _id != null;

  // Méthode pour initialiser l'objet à partir d'un JSON
  void fromJson(Map<String, dynamic>? json) {
    _id = stringFromJson(json, 'id');
  }

  // Surcharge de l'opérateur d'égalité pour comparer les objets Model par leur identifiant
  @override
  bool operator ==(dynamic other) {
    return other._id == this._id;
  }

  // Surcharge de la méthode hashCode pour utiliser l'identifiant
  @override
  int get hashCode => this._id.hashCode;

  // Méthode abstraite pour convertir l'objet en JSON
  Map<String, dynamic>? toJson();

  // Surcharge de la méthode toString pour représenter l'objet en format JSON
  @override
  String toString() {
    return toJson().toString();
  }

  // Méthode pour obtenir une couleur à partir d'un JSON
  Color colorFromJson(Map<String, dynamic>? json, String attribute, {String defaultHexColor = "#000000"}) {
    try {
      return Ui.parseColor(json != null
          ? json[attribute] != null
          ? json[attribute].toString()
          : defaultHexColor
          : defaultHexColor);
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir une chaîne de caractères à partir d'un JSON
  String stringFromJson(Map<String, dynamic>? json, String attribute, {String defaultValue = ''}) {
    try {
      return json != null
          ? json[attribute] != null
          ? json[attribute].toString()
          : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir une date à partir d'un JSON
  DateTime? dateFromJson(Map<String, dynamic>? json, String attribute, {DateTime? defaultValue}) {
    try {
      return json != null
          ? json[attribute] != null
          ? DateTime.parse(json[attribute]).toLocal()
          : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir une durée à partir d'un JSON et la formater
  String durationFromJson(Map<String, dynamic>? json, String attribute,
      {String defaultValue = '00:00', String fromFormat = 'HH:mm', String toFormat = "HH'h' mm'm'"}) {
    try {
      return DateFormat(toFormat).format(DateFormat(fromFormat).parse(stringFromJson(json, attribute, defaultValue: defaultValue)));
    } catch (e) {
      return DateFormat(toFormat).format(DateFormat(fromFormat).parse(defaultValue));
    }
  }

  // Méthode pour obtenir une map (dictionnaire) à partir d'un JSON
  dynamic mapFromJson(Map<String, dynamic>? json, String attribute, {Map<dynamic, dynamic>? defaultValue}) {
    try {
      return json != null
          ? json[attribute] != null
          ? jsonDecode(json[attribute])
          : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir un entier à partir d'un JSON
  int intFromJson(Map<String, dynamic>? json, String attribute, {int defaultValue = 0}) {
    try {
      if (json != null && json[attribute] != null) {
        if (json[attribute] is int) {
          return json[attribute];
        }
        return int.parse(json[attribute]);
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir un double à partir d'un JSON
  double doubleFromJson(Map<String, dynamic>? json, String attribute, {int decimal = 2, double defaultValue = 0.0}) {
    try {
      if (json != null && json[attribute] != null) {
        if (json[attribute] is double) {
          return double.parse(json[attribute].toStringAsFixed(decimal));
        }
        if (json[attribute] is int) {
          return double.parse(json[attribute].toDouble().toStringAsFixed(decimal));
        }
        return double.parse(double.tryParse(json[attribute])!.toStringAsFixed(decimal));
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir un booléen à partir d'un JSON
  bool boolFromJson(Map<String, dynamic>? json, String attribute, {bool defaultValue = false}) {
    try {
      if (json != null && json[attribute] != null) {
        if (json[attribute] is bool) {
          return json[attribute];
        } else if ((json[attribute] is String) && !['0', '', 'false'].contains(json[attribute])) {
          return true;
        } else if ((json[attribute] is int) && ![0, -1].contains(json[attribute])) {
          return true;
        }
        return false;
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir une liste d'objets à partir d'un JSON
  List<T> listFromJsonArray<T>(Map<String, dynamic>? json, List<String> attribute, T Function(Map<String, dynamic>?) callback) {
    String _attribute = attribute.firstWhere((element) => (json?[element] != null), orElse: () => '');
    return listFromJson(json, _attribute, callback);
  }

  // Méthode pour obtenir une liste d'objets à partir d'un JSON
  List<T> listFromJson<T>(Map<String, dynamic>? json, String attribute, T Function(Map<String, dynamic>?) callback) {
    try {
      List<T> _list = <T>[];
      if (json != null && json[attribute] != null && json[attribute] is List && json[attribute].length > 0) {
        json[attribute].forEach((v) {
          if (v is Map<String, dynamic>?) {
            _list.add(callback(v));
          }
        });
      }
      return _list;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute.toString() + '[' + e.toString() + ']');
    }
  }

  // Méthode pour obtenir un objet à partir d'un JSON
  T? objectFromJson<T>(Map<String, dynamic>? json, String attribute, T Function(Map<String, dynamic>?) callback, {T? defaultValue}) {
    try {
      if (json != null && json[attribute] != null && json[attribute] is Map<String, dynamic>?) {
        return callback(json[attribute]);
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ' + attribute + '[' + e.toString() + ']');
    }
  }
}
