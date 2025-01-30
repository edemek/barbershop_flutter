import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.1:8000"; // Changez avec votre URL de base

  /// Connexion utilisateur
  static Future<http.Response> login(String email, String password) async {

    final url = Uri.parse("$baseUrl/login/");
    final body = {
      "email": email,
      "password": password,
    };
    return await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });
  }

  static Future<http.Response> register(String name, String phone, String password) async {
    final url = Uri.parse("$baseUrl/register/");
    print("Nom complet api:"+name);
    final body = {
      "name": name,
      "phone":phone,
      "password": password,
    };
    print("Nom complet api2:"+name);
    return await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });

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
}
