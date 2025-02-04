import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../features/Salon/models/salon_model.dart';

class ApiService {

  static const String baseUrl = "https://barber.businesshelpconsulting.com"; // Changez avec votre URL de base

  /// Connexion utilisateur
  static Future<http.Response> login(String phone, String password) async {
    final url = Uri.parse("$baseUrl/api/login"); // ✅ Vérifie bien que c'est le bon chemin

    print("Request URL: $url"); // 🔍 Debug

    final body = jsonEncode({
      "phone_number": phone,// phone seule pour simuler
      "password": password,
    });

    final response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
    });

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");


    return response;
  }


  static Future<http.Response> register(String name, String phone,String email, String password,String password_confirmation) async {
    final url = Uri.parse("$baseUrl/api/register");
    print("Nom complet api:"+name);
    final body =jsonEncode( {
      "name": name,
      "phone_number":phone,
      "email":email,
      "password":password,
      "password_confirmation": password_confirmation,
    });
    final response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
    });

    print("Nom complet api2:"+name);
    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    return response;


  }

  /// Demander un lien de réinitialisation
  static Future<http.Response> requestPasswordReset(String email) async {
    final url = Uri.parse("$baseUrl/password-reset-request/");
    final body = {
      "email": email,
    };
    return await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });
  }

  /// Réinitialiser le mot de passe
  static Future<http.Response> resetPassword(String token, String newPassword) async {
    final url = Uri.parse("$baseUrl/password-reset/");
    final body = {
      "token": token,
      "new_password": newPassword,
    };
    return await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });
  }

  /// Obtenir l'aide client
  static Future<http.Response> getSupportInfo() async {
    final url = Uri.parse("$baseUrl/support-info/");
    return await http.get(url);
  }
  static Future<List<Salon>> getSalons() async {
    final url = Uri.parse("$baseUrl/api/salons"); // Vérifiez l'URL exacte de l'API

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((data) => Salon.fromJson(data)).toList();
      } else {
        debugPrint("Erreur HTTP ${response.statusCode}: ${response.body}");
        return [];
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération des salons: $e");
      return [];
    }
  }
  /// 🔹 Ajouter un salon (POST)
  static Future<bool> createSalon(Salon salon) async {
    final url = Uri.parse("$baseUrl/api/salons");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(salon.toJson()), // Utilisation directe de toJson()
      );

      if (response.statusCode == 201) {
        debugPrint("Salon ajouté avec succès !");
        return true;
      } else {
        debugPrint("Erreur lors de l'ajout du salon: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Erreur lors de l'ajout du salon: $e");
      return false;
    }
  }
}

